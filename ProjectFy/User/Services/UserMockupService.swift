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
            groups: nil,
            applications: nil,
            available: true,
            areaExpertise: "iOS Developer"
        )
    ]
    
    func getUser(with id: String) -> User? {
        return users.first(where: {$0.id == id})
    }
    
    func create(_ user: User) {
        users.append(user)
    }
    
    func update(_ user: User) throws {
        guard let index = users.firstIndex(where: {$0.id == user.id}) else {
            throw URLError(.fileDoesNotExist)
        }
        
        users[index] = user
    }
    
    func getUsers(completion: @escaping ([User]?) -> Void) {
        completion(users)
    }
    
    func delete(with id: String) {
        guard let index = users.firstIndex(where: {$0.id == id}) else { return }
        users.remove(at: index)
    }
}
