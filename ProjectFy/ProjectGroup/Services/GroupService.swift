//
//  GroupService.swift
//  ProjectFy
//
//  Created by Iago Ramos on 16/08/23.
//

import Foundation

final class GroupService: DBCollection, GroupProtocol {
    
    init() {
        super.init(collectionName: "groups")
    }
    
    func create(_ group: ProjectGroup) throws {
        try create(group, with: group.id)
    }
    
    func update(_ group: ProjectGroup) throws {
        try update(group, with: group.id)
    }
    
    func getGroups(completion: @escaping ([ProjectGroup]?) -> Void) {
        addSnapshotListener { (groups: [ProjectGroup]?) in
            completion(groups)
        }
    }
    
    func remove(member: ProjectGroup.Member, from group: ProjectGroup, completion: @escaping () -> Void) {
        runTransaction(on: group.id) {
            var group = group
            group.members.removeAll(where: { $0.id == member.id })
            
            return group
        } completion: {
            completion()
        }
    }
}
