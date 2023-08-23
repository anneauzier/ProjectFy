//
//  InfoNotification.swift
//  ProjectFy
//
//  Created by Iago Ramos on 22/08/23.
//

import Foundation

struct InfoNotification: Notification {
    var id: String
    var targetID: String
    var title: String
    var body: String
    var appBody: String
    var date = Date()
    
    enum CodingKeys: String, CodingKey {
        case id
        case targetID = "target_id"
        case title
        case body
        case appBody
        case date
    }
    
    init(targetID: String, advertisement: Advertisement) {
        self.id = UUID().uuidString
        self.targetID = targetID
        self.title = advertisement.title
        
        let body = "You were **accepted** in the project **\(advertisement.title)**"
        
        self.appBody = body
        self.body = body.replacingOccurrences(of: "*", with: "")
    }
}
