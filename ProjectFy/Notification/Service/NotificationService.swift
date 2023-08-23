//
//  NotificationService.swift
//  ProjectFy
//
//  Created by Iago Ramos on 18/08/23.
//

import Foundation

final class NotificationService: DBCollection, NotificationProtocol {
    
    init() {
        super.init(collectionName: "notifications")
    }
    
    func create(_ notification: any Notification) throws {
        try create(notification, with: notification.id)
    }
    
    func update(_ notification: any Notification) throws {
        try update(notification, with: notification.id)
    }
    
    func getNotifications<T: Notification>(completion: @escaping ([T]?) -> Void) {
        addSnapshotListener { (notifications: [T]?) in
            completion(notifications)
        }
    }
}
