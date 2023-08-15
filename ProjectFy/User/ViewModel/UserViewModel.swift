//
//  UserViewModel.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

final class UserViewModel: ObservableObject {
    
    @Published private(set) var user: User?
    private var userID: String?
    
    private var users: [User] = []
    private let service: UserProtocol
    
    init(service: UserProtocol) {
        self.service = service
        
        service.getUsers { [weak self] users in
            guard let self = self, let users = users else { return }
            
            self.users = users
            
            guard let userID = self.userID else {
                return
            }
            
            self.user = users.first(where: { $0.id == userID })
        }
    }
    
    func createUser(_ user: User) {
        do {
            try service.create(user)
        } catch {
            print("Cannot create user: \(user)")
        }
    }
    
    func setUser(with id: String) {
        userID = id
    }
    
    func getUser(with id: String) -> User? {
        return users.first(where: { $0.id == id })
    }
    
    func editUser(_ user: User) {
        do {
            try service.update(user)
        } catch {
            print("Cannot update advertisement: \(error)")
        }
    }
    
    func deleteUser(with id: String) {
        service.delete(with: id)
    }
    
    func isUserInfoFilled() -> Bool {
        guard let user = user else { return false }
        
        if user.name.isEmpty, user.areaExpertise.isEmpty, user.region.isEmpty, user.interestTags.isEmpty {
            return false
        }
        
        return true
    }
}
