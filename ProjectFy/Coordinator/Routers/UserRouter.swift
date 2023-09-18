//
//  UserRouter.swift
//  ProjectFy
//
//  Created by Iago Ramos on 18/09/23.
//

import Foundation
import SwiftUI

enum UserRouter: NavigationRouter {
    case user(User)
    case editUser(User)
    case deleteAccount
    
    var transition: NavigationTransitionStyle {
        switch self {
        case .user:
            return .push
            
        case .editUser:
            return .presentModally
            
        case .deleteAccount:
            return .presentFullscreen
        }
    }
    
    @ViewBuilder
    func view() -> some View {
        VStack {
            switch self {
            case .user(let user):
                UserView(user: user)
                
            case .editUser(let user):
                EditUserView(editingUser: user)
                
            case .deleteAccount:
                SignInView(isDeletingAccount: true)
            }
        }
    }
}
