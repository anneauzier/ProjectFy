//
//  UserProtocol.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import Foundation

protocol UserProtocol {

    func getUsers() -> [User]
    func getUser(id: String) -> User?

    func createUser(_ user: User)
    func updateUser(_ user: User)
    func deleteUser(id: String)

}
