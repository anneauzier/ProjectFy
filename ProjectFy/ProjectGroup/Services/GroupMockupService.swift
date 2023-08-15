//
//  GroupMockupService.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import Foundation

final class GroupMockupService: ObservableObject, GroupProtocol {

    private var groups: [ProjectGroup] = [
        ProjectGroup(id: "1213",
                     name: "Adventure Game",
                     description: "Lorem Ipsum is simply dummy text.",
                     avatar: "Group2",
                     adminID: "123456",
                     members: [:],
                     link: "https://trello.com/b/DwEhWYYJ/projectfy",
                     tasks: []),
        ProjectGroup(id: "12134",
                     name: "God Of War - Clone",
                     description: "Lorem Ipsum is simply dummy text.",
                     avatar: "Group4",
                     adminID: "123455",
                     members: [:],
                     link: "https://trello.com/b/DwEhWYYJ/projectfy",
                     tasks: []),
        ProjectGroup(id: "12135",
                     name: "GTA RJ",
                     description: "Lorem Ipsum is simply dummy text.",
                     avatar: "Group5",
                     adminID: "123454",
                     members: [:],
                     link: "https://trello.com/b/DwEhWYYJ/projectfy",
                     tasks: [])
    ]
    
    func getGroups() -> [ProjectGroup] {
        return groups
    }
    
    func getGroup(id: String) -> ProjectGroup? {
        return groups.first(where: {$0.id == id})
    }
    
    func createGroup(_ group: ProjectGroup) {
        groups.append(group)
    }
    
    func updateGroup(_ group: ProjectGroup) {
        guard let index = groups.firstIndex(where: {$0.id == group.id}) else { return }
        groups[index] = group
        
    }
    
    func deleteGroup(id: String) {
        guard let index = groups.firstIndex(where: {$0.id == id}) else { return }
        groups.remove(at: index)
    }
}
