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
    let positions: [Position]
    var link: String
    let tasks: [Task]
    
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
    }
}
