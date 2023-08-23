//
//  SignInWithAppleService.swift
//  ProjectFy
//
//  Created by Iago Ramos on 10/08/23.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import CryptoKit

@MainActor
final class SignInWithAppleService: NSObject, AuthenticationProtocol {
    
    private var currentNonce: String?
    private var completionHandler: ((Result<SignInResult, Error>) -> Void)?
    
    func signIn() async throws -> SignInResult {
        let result = try await startSignInWithAppleFlow()
        
        let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                  idToken: result.identityToken,
                                                  rawNonce: result.nonce)
        
        let signedUser = try await signIn(with: credential).user

        let signInResult = SignInResult(identityToken: signedUser.uid,
                                        nonce: result.nonce,
                                        name: result.name,
                                        email: result.email)
        
        if let name = result.name {
            changeDisplayName(to: name)
        }
        
        return signInResult
    }
    
    private func changeDisplayName(to name: String) {
        guard let user = Auth.auth().currentUser else { return }
        
        if let currentDisplayName = user.displayName, !currentDisplayName.isEmpty {
            return
        }
        
        let changeRequest = user.createProfileChangeRequest()
        
        changeRequest.displayName = name
        changeRequest.commitChanges()
    }
}

// MARK: - Sign In Request
extension SignInWithAppleService {
    
    func startSignInWithAppleFlow() async throws -> SignInResult {
        try await withCheckedThrowingContinuation { continuation in
            self.startSignInWithAppleFlow { result in
                switch result {
                case .success(let signInAppleResult):
                    continuation.resume(returning: signInAppleResult)
                    return
                case .failure(let error):
                    continuation.resume(throwing: error)
                    return
                }
            }
        }
    }

    func startSignInWithAppleFlow(completion: @escaping (Result<SignInResult, Error>) -> Void) {
        guard let topVC = Utils.shared.topViewController() else {
            completion(.failure(URLError(.badURL)))
            return
        }

        let nonce = randomNonceString()
        currentNonce = nonce
        completionHandler = completion

        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = topVC
        authorizationController.performRequests()
    }
}

extension SignInWithAppleService: ASAuthorizationControllerDelegate {
    
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
         guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
               let identityToken = credential.identityToken,
               let identityTokenString = String(data: identityToken, encoding: .utf8),
               let nonce = currentNonce else {
             
             completionHandler?(.failure(URLError(.badServerResponse)))
             return
         }
        
        var name: String?
        let email = credential.email
        
        if let fullName = credential.fullName {
            name = PersonNameComponentsFormatter().string(from: fullName)
        }
        
        let tokens = SignInResult(identityToken: identityTokenString,
                                           nonce: nonce,
                                           name: name,
                                           email: email)
        completionHandler?(.success(tokens))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
        completionHandler?(.failure(URLError(.cannotFindHost)))
    }
}

// MARK: - Cryptography functions
extension SignInWithAppleService {
    
    func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    
    func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
        
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}

extension UIViewController: ASAuthorizationControllerPresentationContextProviding {
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
