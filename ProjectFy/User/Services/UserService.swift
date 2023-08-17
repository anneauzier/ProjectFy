//
//  UserService.swift
//  ProjectFy
//
//  Created by Iago Ramos on 11/08/23.
//

import Foundation

final class UserService: DBCollection, UserProtocol {
    
    init() {
        super.init(collectionName: "users")
    }
    
    func create(_ user: User) throws {
        try create(user, with: user.id)
    }
    
    func update(_ user: User) throws {
        try update(user, with: user.id)
    }
    
    func getUsers(completion: @escaping ([User]?) -> Void) {
        addSnapshotListener { (users: [User]?) in
            completion(users)
        }
    }
}
