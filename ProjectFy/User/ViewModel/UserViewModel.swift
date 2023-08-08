//
//  UserViewModel.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

final class UserViewModel: ObservableObject {
    
    @Published var users: [User]
    @Published var availability: String
    
    private let service: UserProtocol
    
    init(service: UserProtocol) {
        self.service = service
        self.availability = "Disponível"
        self.users = service.getUsers()
    }
    
    func createUser (_ user: User) {
        service.createUser(user)
        updateUsers()
    }
    
    func getUser(id: String) -> User? {
        return service.getUser(id: id)
    }
    
    func editUser(_ user: User) {
        service.updateUser(user)
        availability = user.available ? "Disponível" : "Indisponível"
        updateUsers()
    }
    
    func deleteUser(id: String) {
        service.deleteUser(id: id)
        updateUsers()
    }
    
    private func updateUsers() {
        users = service.getUsers()
    }
}
