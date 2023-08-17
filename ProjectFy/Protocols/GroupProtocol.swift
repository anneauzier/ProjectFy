//
//  GroupProtocol.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import Foundation

protocol GroupProtocol {

//    func getGroups() -> [ProjectGroup]
//    func getGroup(id: String) -> ProjectGroup?
//
//    func createGroup(_ group: ProjectGroup)
//    func updateGroup(_ group: ProjectGroup)
//    func deleteGroup(id: String)
    
    func create(_ group: ProjectGroup) throws
    func getGroups(completion: @escaping ([ProjectGroup]?) -> Void)
    func update(_ group: ProjectGroup) throws
    func delete(with id: String)

}
