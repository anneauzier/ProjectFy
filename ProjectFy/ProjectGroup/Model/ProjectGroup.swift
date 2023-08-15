//
//  ProjectGroup.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct ProjectGroup: Hashable, Codable {
    let id: String
    
    let name: String
    let description: String
    let avatar: String
    let adminID: String
    let members: [String: Position]
    var link: String
    let tasks: [Task]
    
    struct Position: Hashable, Codable {
        let id: String
        var title: String
        var description: String
        var vacancies: Int
        var applied: [User]
        var joined: [User]
    }
    
    struct Task: Hashable, Codable {
        let id: String
        
        let ownerID: String
        var taskDescription: String
        let time: Date
    }
    
    static func == (lhs: ProjectGroup, rhs: ProjectGroup) -> Bool {
        return (
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.avatar == rhs.avatar &&
            lhs.adminID == rhs.adminID &&
            lhs.members == rhs.members &&
            lhs.link == rhs.link &&
            lhs.tasks == rhs.tasks
        )
    }
}
