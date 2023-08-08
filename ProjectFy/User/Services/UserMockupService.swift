//
//  UserMockupService.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import Foundation

final class UserMockupService: UserProtocol, ObservableObject {

    private var users: [User] = [
        User(
            id: "1234",
            name: "Iago",
            username: "@iagoM",
            email: "mirandolaiago@gmail.com",
            description: nil,
            avatar: "Group1",
            region: "AM, Brasil",
            entryDate: Date(),
            interestTags: "Level Design, Design, Game Design, Programação",
            expertise: .beginner,
            groupsID: nil,
            applicationsID: [],
            available: true,
            areaExpertise: "iOS Developer"
        )
    ]
    
    func getUsers() -> [User] {
        return users
    }
    
    func getUser(id: String) -> User? {
        return users.first(where: {$0.id == id})
    }
    
    func createUser(_ user: User) {
        users.append(user)
    }
    
    func updateUser(_ user: User) {
        guard let index = users.firstIndex(where: {$0.id == user.id}) else { return }
        users[index] = user
    }
    
    func deleteUser(id: String) {
        guard let index = users.firstIndex(where: {$0.id == id}) else { return }
        users.remove(at: index)
    }
    
    func apply(to positionID: String) {
        guard var user = users.first else { return }
        
        user.applicationsID.append(positionID)
        updateUser(user)
    }
    
    func unapply(from positionID: String) {
        guard var user = users.first else { return }
        
        user.applicationsID.removeAll(where: { $0 == positionID })
        updateUser(user)
    }
}
