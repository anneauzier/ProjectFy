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
    case advertisementDetails(User, Advertisement)
    case roleDetails(User, Advertisement, ProjectGroup.Position)
    case profile(User)
    case deleteAccount
    
    var transition: NavigationTransitionStyle {
        switch self {
        case .user:
            return .push
            
        case .editUser:
            return .presentModally
            
        case .advertisementDetails:
            return .push
            
        case .roleDetails:
            return .presentModally
            
        case .profile:
            return .push
            
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
                
            case .advertisementDetails(let user, let advertisement):
                DetailsAdvertisementView(user: user, advertisement: advertisement, isUserAdvertisement: true)
                
            case .roleDetails(let user, let advertisement, let position):
                AdView.PositionDetails(user: user, advertisement: advertisement, position: position)
                
            case .profile(let user):
                UserView(user: user, presentUsersProfile: true)
                
            case .deleteAccount:
                SignInView(isDeletingAccount: true)
            }
        }
    }
}
