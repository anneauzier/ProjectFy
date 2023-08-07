//
//  Advertisement.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

struct Advertisement: Hashable {
    static var mock: [Advertisement] = [
        Advertisement(
            id: "1234",
            ownerID: "1234",
            title: "Primeiro Anuncio",
            description: "mock1",
            positions: [
                Group.Position(
                    id: "1234",
                    title: "Level designer",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid",
                    vacancies: 3,
                    joined: []
                )
            ],
            applicationsIDs: nil,
            weeklyWorkload: nil,
            ongoing: true,
            tags: ["Level Design", "Game Design", "Design"]
        )
    ]
    
    let id: String
    let ownerID: String
    var title: String
    var description: String
    var positions: [Group.Position]
    var applicationsIDs: [String: Group.Position]?
    var weeklyWorkload: Double?
    var ongoing: Bool
    var tags: [String]
}
