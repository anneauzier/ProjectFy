//
//  SignInRouter.swift
//  ProjectFy
//
//  Created by Iago Ramos on 12/09/23.
//

import Foundation
import SwiftUI

enum SignInRouter: NavigationRouter {
    
    case signin((String) -> Void)
    case waitingForUserInfo(UserViewModel, (User) -> Void)
    
    var transition: NavigationTransitionStyle {
        switch self {
        case .signin:
            return .push
            
        case .waitingForUserInfo:
            return .push
        }
    }
    
    @ViewBuilder
    func view() -> some View {
        VStack {
            switch self {
            case .signin(let completion):
                SignInView(completion: completion)
                
            case .waitingForUserInfo(let userViewModel, let completion):
                LoadingUserInfo(completion: completion)
                    .environmentObject(userViewModel)
            }
        }
    }
}

struct LoadingUserInfo: View {
    @EnvironmentObject var userViewModel: UserViewModel
    let completion: (User) -> Void
    
    var body: some View {
        Text("Loading user info...")
            .onChange(of: userViewModel.user) { user in
                guard let user = user else { return }
                completion(user)
            }
    }
}
