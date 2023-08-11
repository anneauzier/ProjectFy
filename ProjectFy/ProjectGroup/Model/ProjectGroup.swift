//
//  ProjectGroup.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct ProjectGroup: Hashable, Equatable {

    let id: String
    var name: String
    var description: String
    let avatar: String
    let adminID: String
    let members: [String: Position]
    var link: String
    let tasks: [Task]
    
    struct Position: Hashable, Equatable {
        let id: String
        var title: String
        var description: String
        var vacancies: Int
        var joined: [String] // Array of IDs of people that joined that position
    }
    
    struct Task: Hashable, Equatable {
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
