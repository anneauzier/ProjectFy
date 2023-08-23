//
//  NotificationProtocol.swift
//  ProjectFy
//
//  Created by Iago Ramos on 18/08/23.
//

import Foundation

protocol NotificationProtocol {
    
    func create(_ notification: any Notification) throws
    func getNotifications<T: Notification>(completion: @escaping ([T]?) -> Void)
    func update(_ notification: any Notification) throws
    func delete(with id: String)
}
