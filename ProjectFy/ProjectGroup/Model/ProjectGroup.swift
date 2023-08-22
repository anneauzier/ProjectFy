//
//  ProjectGroup.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct ProjectGroup: Hashable, Codable {
    typealias Member = Advertisement.Application
    
    let id: String
    let advertisement: Advertisement
    var name: String
    var description: String
    var members: [Member]
    let avatar: String
    var admin: User
    var link: String
    var tasks: [Task]
    
    enum CodingKeys: String, CodingKey {
        case id
        case advertisement
        case name
        case description
        case members
        case avatar
        case admin
        case link
        case tasks
    }
    
    struct Position: Hashable, Codable {
        let id: String
        var title: String
        var description: String
        var vacancies: Int
    }
    
    struct Task: Identifiable, Hashable, Codable {
        let id: String
        let user: User
        var taskDescription: [String]
        let date: Date
 
        enum CodingKeys: String, CodingKey {
            case id
            case user
            case taskDescription = "task_description"
            case date
        }
        
        init(user: User) {
            self.id = UUID().uuidString
            self.user = user
            self.taskDescription = []
            self.date = Date()
        }
    }
    
    init(id: String,
         advertisement: Advertisement,
         name: String,
         description: String,
         members: [Member],
         avatar: String,
         admin: User,
         link: String,
         tasks: [Task]) {
        self.id = id
        self.advertisement = advertisement
        self.name = name
        self.description = description
        self.members = members
        self.avatar = avatar
        self.admin = admin
        self.link = link
        self.tasks = tasks
    }
    
    init(advertisement: Advertisement) {
        self.id = UUID().uuidString
        self.advertisement = advertisement
        self.name = advertisement.title
        self.description = advertisement.description
        self.members = []
        self.avatar = String.avatars.randomElement() ?? ""
        self.admin = advertisement.owner
        self.link = ""
        self.tasks = []
    }
    
    init() {
        self.id = UUID().uuidString
        self.advertisement = Advertisement(owner: .init(signInResult: .init(identityToken: "", nonce: "", name: "", email: "")))
        self.name = ""
        self.description = ""
        self.members = []
        self.avatar = ""
        self.admin = User(signInResult: .init(identityToken: "", nonce: "", name: "", email: ""))
        self.link = ""
        self.tasks = []
    }
}
