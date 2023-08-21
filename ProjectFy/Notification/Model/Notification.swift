//
//  Notification.swift
//  ProjectFy
//
//  Created by Iago Ramos on 18/08/23.
//

import Foundation

protocol Notification: Hashable, Codable {
    
    var id: String { get set }
    var targetID: String { get set }
    var title: String { get set }
    var body: String { get set }
    var date: Date { get set }
}

struct RequestNotification: Notification {
    var id: String
    var targetID: String
    var title: String
    var body: String
    var date = Date()
    
    var userID: String
    var advertisementID: String
    var accepted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case targetID = "target_id"
        case title
        case body
        case date
        case userID = "user_id"
        case advertisementID = "advertisement_id"
        case accepted
    }
}
