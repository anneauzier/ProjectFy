//
//  String+avatars.swift
//  ProjectFy
//
//  Created by Iago Ramos on 12/08/23.
//

import Foundation

extension String {
    static let avatars = {
        var avatars: [String] = []
        
        for avatarIndex in 1...5 {
            avatars.append("Group\(avatarIndex)")
        }
        
        return avatars
    }()
}
