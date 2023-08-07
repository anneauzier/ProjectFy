//
//  User.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct User {

    let id: String
    var name: String
    var username: String
    let email: String
    let description: String?
    let avatar: String
    var region: String
    let entryDate: Date
    var interestTags: String
    var expertise: Expertise
    var groupsID: [String]?
    let applicationsID: [String]?
    var available: Bool
    var areaExpertise: String
    
    enum Expertise: String, CaseIterable {
        case beginner = "Beginner"
        case intermediary = "Intermediary"
        case advanced = "Advanced"
    }
}
