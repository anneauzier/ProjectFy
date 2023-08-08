//
//  Advertisement.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct Advertisement: Hashable {
    let id: String
    let ownerID: String
    
    var title: String
    var description: String
    var positions: [ProjectGroup.Position]
    var applicationsIDs: [String: ProjectGroup.Position]
    var weeklyWorkload: Double?
    var ongoing: Bool
    var tags: [String]
}
