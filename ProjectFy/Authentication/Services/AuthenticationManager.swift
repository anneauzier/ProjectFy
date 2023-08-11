//
//  AuthenticationManager.swift
//  ProjectFy
//
//  Created by Iago Ramos on 10/08/23.
//

import Foundation
import FirebaseAuth

class AuthenticationManager: NSObject {
    
    @discardableResult
    func signIn(with credential: AuthCredential) async throws -> AuthDataResult {
        return try await Auth.auth().signIn(with: credential)
    }
    
    func getAuthenticatedUser(from users: [User]) throws -> User {
        guard let authenticatedUser = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        
        guard let user = users.first(where: { $0.id == authenticatedUser.uid }) else {
            throw URLError(.fileDoesNotExist)
        }
        
        return user
    }
    
    struct SignInWithAppleResult {
        let identityToken: String
        let nonce: String
        let name: String?
        let email: String?
    }
}
