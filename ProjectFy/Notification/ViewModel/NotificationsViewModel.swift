//
//  NotificationsViewModel.swift
//  ProjectFy
//
//  Created by Iago Ramos on 18/08/23.
//

import Foundation

final class NotificationsViewModel: ObservableObject {
    @Published private(set) var notifications: [any Notification] = []
    private let service: NotificationService
    
    init(service: NotificationService) {
        self.service = service
    }
    
    func startListening(with id: String) {
        self.listen(to: RequestNotification.self, with: id)
    }
    
    private func listen<T: Notification>(to: T.Type, with id: String) {
        service.getNotifications { [weak self] (notifications: [T]?) in
            guard let self = self, var notifications = notifications else { return }
            
            notifications = notifications.filter({ $0.targetID == id })
            
            self.notifications.removeAll(where: { type(of: $0) == T.self })
            self.notifications.append(contentsOf: notifications)
        }
    }
    
    func createNotification(_ notification: any Notification) {
        do {
            try service.create(notification)
        } catch {
            print("Cannot create advertisement: \(error.localizedDescription)")
        }
    }
    
    func getNotification(with id: String) -> (any Notification)? {
        return notifications.first(where: { $0.id == id })
    }
    
    func editNotification(_ notification: any Notification) {
        do {
            try service.update(notification)
        } catch {
            print("Cannot update advertisement: \(error)")
        }
    }
    
    func deleteRequestNotification(userID: String, advertisementID: String) {
        var notification: RequestNotification? {
            let requests = self.notifications.compactMap { $0 as? RequestNotification }
            return requests.first(where: { $0.userID == userID && $0.advertisementID == advertisementID })
        }
        
        guard let notification = notification else { return }
        service.delete(with: notification.id)
    }
}
