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
    var weeklyWorkload: Double?
    var ongoing: Bool
    var tags: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case ownerID = "owner_id"
        case title
        case description
        case positions
        case weeklyWorkload = "weekly_workload"
        case ongoing
        case tags
    }
    
    init(id: String,
         ownerID: String,
         title: String,
         description: String,
         positions: [ProjectGroup.Position],
         weeklyWorkload: Double?,
         ongoing: Bool,
         tags: String) {
        self.id = id
        self.title = title
        self.ownerID = ownerID
        self.description = description
        self.positions = positions
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
        self.weeklyWorkload = nil
        self.ongoing = false
        self.tags = ""
    }
}
