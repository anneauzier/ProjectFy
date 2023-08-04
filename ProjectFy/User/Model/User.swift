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
            id: "1234",
            name: "Iago",
            username: "@iagoM",
            email: "mirandolaiago@gmail.com",
            description: nil,
            avatar: "Group1",
            region: "AM, Brasil",
            entryDate: Date(),
            interestTags: "Level Design, Design, Game Design, Programação",
            expertise: .beginner,
            groupsID: nil,
            applicationsID: nil,
            available: true,
            areaExpertise: "iOS Developer"
        ),
        User(
            id: "12345",
            name: "Anne",
            username: "@anneB",
            email: "anne@gmail.com",
            description: nil,
            avatar: "Group2",
            region: "CE, Brasil",
            entryDate: Date(),
            interestTags: "Level Design, Design, Game Design, Programação",
            expertise: .intermediary,
            groupsID: nil,
            applicationsID: nil,
            available: true,
            areaExpertise: "iOS Developer"
        ),
        User(
            id: "123456",
            name: "Jade",
            username: "@arrudaJade",
            email: "jade@gmail.com",
            description: nil,
            avatar: "Group3",
            region: "SC, Brasil",
            entryDate: Date(),
            interestTags: "Level Design, Design, Game Design, Programação",
            expertise: .beginner,
            groupsID: nil,
            applicationsID: nil,
            available: true,
            areaExpertise: "iOS Developer"
        )
    ]
    
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
