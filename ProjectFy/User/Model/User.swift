//
//  User.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

// TODO: adicionar codingkeys

struct User: Hashable, Codable {

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
    var groups: [ProjectGroup]?
    let applications: [ProjectGroup.Position]?
    var available: Bool
    var areaExpertise: String
    
    init(id: String,
         name: String,
         username: String,
         email: String,
         description: String?,
         avatar: String,
         region: String,
         entryDate: Date,
         interestTags: String,
         expertise: Expertise,
         groups: [ProjectGroup]? = nil,
         applications: [ProjectGroup.Position]?,
         available: Bool,
         areaExpertise: String
    ) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.description = description
        self.avatar = avatar
        self.region = region
        self.entryDate = entryDate
        self.interestTags = interestTags
        self.expertise = expertise
        self.groups = groups
        self.applications = applications
        self.available = available
        self.areaExpertise = areaExpertise
    }
    
    init(signInResult: SignInResult) {
        self.id = signInResult.identityToken
        self.name = signInResult.name ?? ""
        self.username = ""
        self.email = signInResult.email ?? ""
        self.description = ""
        self.avatar = String.avatars.randomElement() ?? ""
        self.region = ""
        self.entryDate = Date()
        self.interestTags = ""
        self.expertise = .beginner
        self.groups = []
        self.applications = []
        self.available = true
        self.areaExpertise = ""
    }
    
    enum Expertise: String, CaseIterable, Codable {
        case beginner = "Beginner"
        case intermediary = "Intermediary"
        case advanced = "Advanced"
    }
}
