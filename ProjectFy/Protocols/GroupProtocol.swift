//
//  GroupProtocol.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import Foundation

protocol GroupProtocol {

    func create(_ group: ProjectGroup) throws
    func getGroups(completion: @escaping ([ProjectGroup]?) -> Void)
    func update(_ group: ProjectGroup) throws
    func delete(with id: String)
    func remove(member: ProjectGroup.Member, from group: ProjectGroup, completion: @escaping () -> Void)

}
