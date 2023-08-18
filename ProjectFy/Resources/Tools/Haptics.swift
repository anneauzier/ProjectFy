//
//  Haptics.swift
//  ProjectFy
//
//  Created by Iago Ramos on 08/08/23.
//

import Foundation
import UIKit

final class Haptics {
    static let shared = Haptics()
    
    private init() {}
    
    func selection() {
        let selectionFeedbackGenerator = UISelectionFeedbackGenerator()
        selectionFeedbackGenerator.selectionChanged()
    }
    
    func notification(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(type)
    }
    
    func impact(_ type: UIImpactFeedbackGenerator.FeedbackStyle) {
        let impactFeedbackgenerator = UIImpactFeedbackGenerator(style: .rigid)
        impactFeedbackgenerator.prepare()
        impactFeedbackgenerator.impactOccurred()
    }
}
