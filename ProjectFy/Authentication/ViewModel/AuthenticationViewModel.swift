//
//  AuthenticationViewModel.swift
//  ProjectFy
//
//  Created by Iago Ramos on 10/08/23.
//

import Foundation
import FirebaseAuth

@MainActor
final class AuthenticationViewModel: ObservableObject {
    
    @Published var isAuthenticated = false
    var authenticationService: AuthenticationProtocol?
    
    init() {
        isAuthenticated = self.getAuthenticatedUser() != nil
        
        handleAuthenticationChanges { [weak self] user in
            self?.isAuthenticated = user != nil
        }
    }
    
    func signIn(completion: @escaping (SignInResult) -> Void) {
        guard let authenticationService = authenticationService else {
            print("No AuthenticationService found!")
            return
        }
        
        Task {
            do {
                let signInResult = try await authenticationService.signIn()
                self.authenticationService = nil
                
                completion(signInResult)
            } catch {
                print("Unable to authenticate user: \(error.localizedDescription)")
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Unable to sign out: \(error.localizedDescription)")
        }
    }
    
    func handleAuthenticationChanges(completion: @escaping (FirebaseAuth.User?) -> Void) {
        Auth.auth().addStateDidChangeListener { _, user in
            completion(user)
        }
    }
    
    func getAuthenticatedUser() -> FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
}
