//
//  AdvertisementsRouter.swift
//  ProjectFy
//
//  Created by Iago Ramos on 14/09/23.
//

import Foundation
import SwiftUI

enum AdvertisementsRouter: NavigationRouter {
    
    case advertisements(User)
    case advertisementDetails(User, Advertisement)
    case roleDetails(User, Advertisement, ProjectGroup.Position)
    case newAdvertisement(User, Advertisement)
    case editAdvertisement(User, Advertisement)
    case editPositions(User, Binding<Advertisement>, Bool)
    case profile(User)
    
    var transition: NavigationTransitionStyle {
        switch self {
        case .advertisements:
            return .push
            
        case .advertisementDetails:
            return .push
            
        case .roleDetails:
            return .presentModally
            
        case .newAdvertisement:
            return .multiple(.presentModally)

        case .editAdvertisement:
            return .multiple(.presentModally)
            
        case .editPositions:
            return .multiple(.push)
            
        case .profile:
            return .push
        }
    }
    
    @ViewBuilder
    func view() -> some View {
        VStack {
            switch self {
            case .advertisements(let user):
                AdvertisementsView(user: user)
                
            case .advertisementDetails(let user, let advertisement):
                DetailsAdvertisementView(user: user, advertisement: advertisement)
                
            case .roleDetails(let user, let advertisement, let position):
                AdView.PositionDetails(user: user, advertisement: advertisement, position: position)
                
            case .newAdvertisement(let owner, let advertisement):
                AdvertisementsView.NewAdvertisement(owner: owner, advertisement: advertisement)

            case .editAdvertisement(let owner, let advertisement):
                AdvertisementsView.NewAdvertisement(owner: owner, advertisement: advertisement, isEditing: true)
                
            case .editPositions(let owner, let advertisement, let isEditing):
                AdvertisementsView.Positions(owner: owner, advertisement: advertisement, isEditing: isEditing)
                
            case .profile(let user):
                UserView(presentUsersProfile: true, user: user)
            }
        }
    }
}
