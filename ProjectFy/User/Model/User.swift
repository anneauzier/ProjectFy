//
//  User.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import Foundation

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
    var available: Bool
    var areaExpertise: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
        case email
        case description
        case avatar
        case region
        case entryDate
        case interestTags = "interest_tags"
        case expertise
        case available
        case areaExpertise = "area_expertise"
    }
    
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
        self.available = true
        self.areaExpertise = ""
    }
    
    enum Expertise: String, CaseIterable, Codable {
        case beginner = "Beginner"
        case intermediary = "Intermediary"
        case advanced = "Advanced"
    }
}
