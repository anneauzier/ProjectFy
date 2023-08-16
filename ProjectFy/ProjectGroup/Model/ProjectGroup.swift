//
//  ProjectGroup.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct ProjectGroup: Hashable, Codable {

    let id: String
    var name: String
    var description: String
    let avatar: String
    let adminID: String
    var link: String
    let tasks: [Task]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case avatar
        case adminID = "admin_id"
        case link
        case tasks
    }
    
    struct Position: Hashable, Codable {
        let id: String
        var title: String
        var description: String
        var vacancies: Int
    }
    
    struct Task: Hashable, Codable {
        let id: String
        
        let ownerID: String
        var taskDescription: String
        let time: Date
        
        enum CodingKeys: String, CodingKey {
            case id
            case ownerID = "owner_id"
            case taskDescription = "task_description"
            case time
        }
    }
    
    init(id: String,
         name: String,
         description: String,
         avatar: String,
         adminID: String,
         link: String,
         tasks: [Task]) {
        self.id = id
        self.name = name
        self.description = description
        self.avatar = avatar
        self.adminID = adminID
        self.link = link
        self.tasks = tasks
    }
    
    init() {
        self.id = UUID().uuidString
        self.name = ""
        self.description = ""
        self.avatar = ""
        self.adminID = ""
        self.link = ""
        self.tasks = []
    }
}
