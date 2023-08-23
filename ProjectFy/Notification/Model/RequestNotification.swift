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
    
    var advertisement: Advertisement
    var application: Advertisement.Application
    var accepted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case targetID = "target_id"
        case title
        case body
        case appBody = "app_body"
        case date
        case advertisement
        case application
        case accepted
    }
    
    init(id: String, targetID: String, title: String, body: String, appBody: String, date: Date = Date(), advertisement: Advertisement, application: Advertisement.Application, accepted: Bool? = nil) {
        self.id = id
        self.targetID = targetID
        self.title = title
        self.body = body
        self.appBody = appBody
        self.date = date
        self.advertisement = advertisement
        self.application = application
        self.accepted = accepted
    }
    
    init(target: User, advertisement: Advertisement, application: Advertisement.Application) {
        self.id = UUID().uuidString
        self.targetID = target.id
        self.date = Date()
        self.advertisement = advertisement
        self.application = application
        self.accepted = nil
        
        let appBody = "**\(application.user.name)** has requested to join in your project **\(advertisement.title)** as **\(application.position.title)**"
        
        self.title = advertisement.title
        self.appBody = appBody
        self.body = appBody.replacingOccurrences(of: "*", with: "")
    }
}
