//
//  NotificationsRouter.swift
//  ProjectFy
//
//  Created by Iago Ramos on 18/09/23.
//

import Foundation
import SwiftUI

enum NotificationsRouter: NavigationRouter {
    case notifications(User)
    
    var transition: NavigationTransitionStyle {
        .push
    }
    
    @ViewBuilder
    func view() -> some View {
        VStack {
            switch self {
            case .notifications(let user):
                Notifications(user: user)
            }
        }
    }
}
