//
//  ProjectGroup.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct ProjectGroup {
    let id = UUID().uuidString
    
    let name: String
    let description: String
    let avatar: String
    let adminID: String
    let members: [String: Position]
    let link: String
    let tasks: [Task]
    
    struct Position {
        let id = UUID().uuidString
        
        let title: String
        let vacancies: Int
        var vacanciesFilled: Int
    }
    
    struct Task {
        let id = UUID().uuidString
        
        let ownerID: String
        var taskDescription: String
        let time: Date
    }
}
