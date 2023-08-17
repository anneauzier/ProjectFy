//
//  Task.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 15/08/23.
//

import Foundation

struct Tasks: Identifiable, Codable {

    var id: String
    var senderName: String
    var text: [String]
    var received: Bool
    var time: Date

}
