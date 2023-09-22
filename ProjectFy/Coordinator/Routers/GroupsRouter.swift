//
//  GroupsRouter.swift
//  ProjectFy
//
//  Created by Iago Ramos on 18/09/23.
//

import Foundation
import SwiftUI

enum GroupsRouter: NavigationRouter {
    case groups(User)
    case tasks(User, ProjectGroup)
    case groupDetails(User, ProjectGroup)
    case editGroup(ProjectGroup)
    
    var transition: NavigationTransitionStyle {
        switch self {
        case .groups:
            return .push
            
        case .tasks:
            return .push
            
        case .groupDetails:
            return .push
            
        case .editGroup:
            return .multiple(.presentModally)
        }
    }
    
    @ViewBuilder
    func view() -> some View {
        VStack {
            switch self {
            case .groups(let user):
                GroupView(user: user)
                
            case .tasks(let user, let group):
                TasksGroupView(user: user, group: group)
                
            case .groupDetails(let user, let group):
                DetailsGroupView(user: user, group: group)
                
            case .editGroup(let group):
                EditDetailsGroup(groupInfo: group)
            }
        }
    }
}
