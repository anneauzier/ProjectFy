//
//  AuthenticationProtocol.swift
//  ProjectFy
//
//  Created by Iago Ramos on 10/08/23.
//

import Foundation
import FirebaseAuth

protocol AuthenticationProtocol {
    
    func signIn() async throws -> SignInResult
}

extension AuthenticationProtocol {
    @discardableResult
    func signIn(with credential: AuthCredential) async throws -> AuthDataResult {
        return try await Auth.auth().signIn(with: credential)
    }
}

struct SignInResult {
    let identityToken: String
    let nonce: String
    let name: String?
    let email: String?
}
