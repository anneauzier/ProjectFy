//
//  Advertisement.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct Advertisement {
    let id = UUID().uuidString
    
    let ownerID: String
    
    let title: String
    let description: String
    let positions: [ProjectGroup.Position]
    let applicationsIDs: [String: ProjectGroup.Position]?
    let weeklyWorkload: Double?
    let tags: [String]
}
