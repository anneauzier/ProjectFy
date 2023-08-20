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
        ProjectGroup(id: "1213",
                     name: "Adventure Game",
                     description: "Lorem Ipsum is simply dummy text.",
                     avatar: "Group2",
                     adminID: "123456",
                     link: "https://trello.com/b/DwEhWYYJ/projectfy",
                     tasks: [
                        ProjectGroup.Tasks(id: "123",
                                           user: User(signInResult: .init(identityToken: "",
                                           nonce: "", name: "Iago", email: "")),
                                           taskDescription: ["Oi, galera", "tudo certo?"],
                                           time: Date()),
                        ProjectGroup.Tasks(id: "456",
                                           user: User(signInResult: .init(identityToken: "",
                                           nonce: "", name: "Anne Auzier", email: "")),
                                           taskDescription: ["Eai", "tudo tranquilo"],
                                           time: Date())
                     ]),
        ProjectGroup(id: "12134",
                     name: "God Of War - Clone",
                     description: "Lorem Ipsum is simply dummy text.",
                     avatar: "Group4",
                     adminID: "123455",
                     link: "https://trello.com/b/DwEhWYYJ/projectfy",
                     tasks: [
                        ProjectGroup.Tasks(id: "123",
                                           user: User(signInResult: .init(identityToken: "",
                                           nonce: "", name: "Iago", email: "")),
                                           taskDescription: ["Oi, galera", "tudo bem?"],
                                           time: Date()),
                        ProjectGroup.Tasks(id: "456",
                                           user: User(signInResult: .init(identityToken: "",
                                           nonce: "", name: "Anne Auzier", email: "")),
                                           taskDescription: ["Eai", "tudo tranquilo"],
                                           time: Date())
                     ]),
        ProjectGroup(id: "12135",
                     name: "GTA RJ",
                     description: "Lorem Ipsum is simply dummy text.",
                     avatar: "Group5",
                     adminID: "123454",
                     link: "https://trello.com/b/DwEhWYYJ/projectfy",
                     tasks: [
                        ProjectGroup.Tasks(id: "123",
                                           user: User(signInResult: .init(identityToken: "",
                                           nonce: "", name: "Iago", email: "")),
                                           taskDescription: ["Oi, galera", "tudo na paz?"],
                                           time: Date()),
                        ProjectGroup.Tasks(id: "456",
                                           user: User(signInResult: .init(identityToken: "",
                                           nonce: "", name: "Anne Auzier", email: "")),
                                           taskDescription: ["Eai", "tudo tranquilo"],
                                           time: Date())
                     ])
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
}
