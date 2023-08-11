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
    
    var authorisationState: AuthorisationState = .unauthorized
    var authenticationService: AuthenticationProtocol?
    
    init() {
        authorisationState = isAuthenticated() ? .authorized : .unauthorized
        handleAuthenticationChanges()
    }
    
    func signIn() {
        guard let authenticationService = authenticationService else {
            print("No AuthenticationService found!")
            return
        }
        
        Task {
            do {
                try await authenticationService.signIn()
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
    
    private func isAuthenticated() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    private func handleAuthenticationChanges() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.authorisationState = user == nil ? .unauthorized : .authorized
        }
    }
    
    enum AuthorisationState {
        case authorized
        case unauthorized
    }
}
