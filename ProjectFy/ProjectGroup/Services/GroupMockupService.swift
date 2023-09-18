//
//  GroupMockupService.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import Foundation

final class GroupMockupService: ObservableObject, GroupProtocol {
    private var listenerCompletion: (([ProjectGroup]?) -> Void)?
    
    private var groups: [ProjectGroup] = [
//        ProjectGroup(id: "1213",
//                     advertisement: Advertisement(owner: .ini)
//                     name: "Adventure Game",
//                     description: "Lorem Ipsum is simply dummy text.",
//                     avatar: "Group2",
//                     adminID: "123456",
//                     link: "https://trello.com/b/DwEhWYYJ/projectfy",
//                     tasks: [])
    ]

    {
        didSet {
            guard let completion = listenerCompletion else { return }
            getGroups(completion: completion)
        }
    }
    
    func create(_ group: ProjectGroup) throws {
        groups.append(group)
    }
    
    func getGroups(completion: @escaping ([ProjectGroup]?) -> Void) {
        self.listenerCompletion = completion
        completion(groups)
    }
    
    func update(_ group: ProjectGroup) throws {
        guard let index = groups.firstIndex(where: {$0.id == group.id}) else { return }
        groups[index] = group
    }
    
    func delete(with id: String) {
        guard let index = groups.firstIndex(where: {$0.id == id}) else { return }
        groups.remove(at: index)
    }
    
    func remove(member: ProjectGroup.Member, from group: ProjectGroup, completion: @escaping () -> Void) {
        guard groups.first(where: {$0.id == group.id}) != nil else { return }
    }
    
    func add(task: ProjectGroup.Task, on group: ProjectGroup) {
    }
}
