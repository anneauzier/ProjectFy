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
    
    var authenticationService: AuthenticationProtocol?
    
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
    
    func isAuthenticated() -> Bool {
        return Auth.auth().currentUser != nil
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
