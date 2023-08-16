//
//  Advertisement.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct Advertisement: Hashable, Codable {
    let id: String
    let ownerID: String
    
    var title: String
    var description: String
    var positions: [ProjectGroup.Position]
    var applications: [Application]
    var weeklyWorkload: Double?
    var ongoing: Bool
    var tags: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case title
        case description
        case positions
        case applications
        case weeklyWorkload = "weekly_workload"
        case ongoing
        case tags
    }
    
    struct Application: Hashable, Codable {
        let position: ProjectGroup.Position
        let user: User
        let joined: Bool
    }
    
    init(id: String,
         ownerID: String,
         title: String,
         description: String,
         positions: [ProjectGroup.Position],
         applications: [Application],
         weeklyWorkload: Double?,
         ongoing: Bool,
         tags: String) {
        self.id = id
        self.title = title
        self.ownerID = ownerID
        self.description = description
        self.positions = positions
        self.applications = applications
        self.weeklyWorkload = weeklyWorkload
        self.ongoing = ongoing
        self.tags = tags
    }
    
    init(ownerID: String) {
        self.id = UUID().uuidString
        self.title = ""
        self.ownerID = ownerID
        self.description = ""
        self.positions = []
        self.applications = []
        self.weeklyWorkload = nil
        self.ongoing = false
        self.tags = ""
    }
}
