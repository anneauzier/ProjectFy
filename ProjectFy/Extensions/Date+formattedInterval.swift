//
//  Date+formattedInterval.swift
//  ProjectFy
//
//  Created by Iago Ramos on 21/08/23.
//

import Foundation

extension Date {
    var formattedInterval: String {
        let formatter = DateComponentsFormatter()
        
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        formatter.zeroFormattingBehavior = .dropAll
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        
        return formatter.string(from: Date().timeIntervalSince(self)) ?? ""
    }
}
