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
    var appBody: String { get set }
    var date: Date { get set }
}
