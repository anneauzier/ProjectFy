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
            avatar: "teste1",
            region: "AM, Brasil",
            entryDate: Date(),
            interestTags: ["Level Design", "Design", "Game Design", "Programação"],
            expertise: .beginner,
            groupsID: nil,
            applicationsID: nil,
            available: true,
            areaExpertise: "iOS Developer"
        ),
        User(
            name: "Anne",
            email: "anne@gmail.com",
            description: nil,
            avatar: "teste2",
            region: "CE, Brasil",
            entryDate: Date(),
            interestTags: ["Level Design", "Design", "Game Design", "Programação"],
            expertise: .intermediary,
            groupsID: nil,
            applicationsID: nil,
            available: false,
            areaExpertise: "iOS Developer"
        ),
        User(
            name: "Jade",
            email: "jade@gmail.com",
            description: nil,
            avatar: "teste3",
            region: "SC, Brasil",
            entryDate: Date(),
            interestTags: ["Level Design", "Design", "Game Design", "Programação"],
            expertise: .advanced,
            groupsID: nil,
            applicationsID: nil,
            available: false,
            areaExpertise: "iOS Developer"
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
    let areaExpertise: String
    
    enum Expertise: String {
        case beginner = "Iniciante"
        case intermediary = "Intermediário"
        case advanced = "Avançado"
    }
}
