//
//  RequestNotification.swift
//  ProjectFy
//
//  Created by Iago Ramos on 21/08/23.
//

import Foundation

struct RequestNotification: Notification {
    var id: String
    var targetID: String
    var title: String
    var body: String
    var appBody: String
    var date = Date()
    
    var userID: String
    var advertisementID: String
    var accepted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case targetID = "target_id"
        case title
        case body
        case appBody = "app_body"
        case date
        case userID = "user_id"
        case advertisementID = "advertisement_id"
        case accepted
    }
    
    init(id: String, targetID: String, title: String, body: String, appBody: String, date: Date = Date(), userID: String, advertisementID: String, accepted: Bool? = nil) {
        self.id = id
        self.targetID = targetID
        self.title = title
        self.body = body
        self.appBody = appBody
        self.date = date
        self.userID = userID
        self.advertisementID = advertisementID
        self.accepted = accepted
    }
    
    init(target: User, sender: User, advertisement: Advertisement, position: String) {
        self.id = UUID().uuidString
        self.targetID = target.id
        self.date = Date()
        self.userID = sender.id
        self.advertisementID = advertisement.id
        self.accepted = nil
        
        let appBody = "**\(sender.name)** has requested to join in your project **\(advertisement.title)** as **\(position)**"
        
        self.title = advertisement.title
        self.appBody = appBody
        self.body = appBody.replacingOccurrences(of: "*", with: "")
    }
}
