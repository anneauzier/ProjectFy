//
//  User.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct User {
    static var mock: [User] = [
        User(
            name: "Iago",
            email: "mirandolaiago@gmail.com",
            description: nil,
            avatar: "teste",
            region: "AM, Brasil",
            entryDate: Date(),
            interestTags: [""],
            expertise: .beginner,
            groupsID: nil,
            applicationsID: nil,
            available: true
        )
    ]
    
    let id = UUID().uuidString
    
    var name: String
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
    
    enum Expertise {
        case beginner
        case intermediary
        case advanced
    }
}
