//
//  User.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct User {
    static var mock: [User] = [
        User(id: "1234",
             name: "Iago Ramos",
             username: "@iagoramoss",
             email: "mirandolaiago@gmail.com",
             description: nil,
             avatar: "teste",
             region: "AM, Brasil",
             entryDate: Date(),
             interestTags: [""],
             expertise: .beginner,
             groupsID: nil,
             applicationsID: nil,
             available: true,
             areaExpertise: "iOS Developer"
        )
    ]
    
    let id: String
    var name: String
    let username: String
    let email: String
    let description: String?
    let avatar: String
    let region: String
    let entryDate: Date
    let interestTags: [String]
    let expertise: Expertise
    let groupsID: [String]?
    let applicationsID: [String]?
    let available: Bool
    let areaExpertise: String
    
    enum Expertise: String {
        case beginner
        case intermediary
        case advanced
    }
}
