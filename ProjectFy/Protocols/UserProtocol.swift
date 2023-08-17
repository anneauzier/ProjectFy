//
//  UserProtocol.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import Foundation

protocol UserProtocol {
    
    func create(_ user: User) throws
    func getUsers(completion: @escaping ([User]?) -> Void)
    func update(_ user: User) throws
    func delete(with id: String)
}
