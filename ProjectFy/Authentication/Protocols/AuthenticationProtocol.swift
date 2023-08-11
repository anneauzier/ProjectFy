//
//  AuthenticationProtocol.swift
//  ProjectFy
//
//  Created by Iago Ramos on 10/08/23.
//

import Foundation
import FirebaseAuth

protocol AuthenticationProtocol {
    
    func signIn() async throws
    func getAuthenticatedUser(from users: [User]) throws -> User
}
