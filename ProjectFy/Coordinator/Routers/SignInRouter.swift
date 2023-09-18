//
//  SignInRouter.swift
//  ProjectFy
//
//  Created by Iago Ramos on 12/09/23.
//

import Foundation
import SwiftUI

enum SignInRouter: NavigationRouter {
    
    case signin((User) -> Void)
    case waitingForUserInfo((User) -> Void)
    case setupInitialConfigs(User, (User) -> Void)
    case start(User, (User) -> Void)
    
    var transition: NavigationTransitionStyle {
        switch self {
        case .signin:
            return .push
            
        case .waitingForUserInfo:
            return .push
            
        case .setupInitialConfigs:
            return .push
            
        case .start:
            return .push
        }
    }
    
    @ViewBuilder
    func view() -> some View {
        VStack {
            switch self {
            case .signin(let completion):
                SignInView(completion: completion)
                
            case .waitingForUserInfo(let completion):
                LoadingUserInfo(completion: completion)
                
            case .setupInitialConfigs(let user, let completion):
                SetupInitialConfigs(user: user, completion: completion)
                
            case .start(let user, let completion):
                StartView(user: user, completion: completion)
            }
        }
    }
}

struct LoadingUserInfo: View {
    @EnvironmentObject var coordinator: Coordinator<SignInRouter>
    
    @EnvironmentObject var userViewModel: UserViewModel
    let completion: (User) -> Void
    
    var body: some View {
        Text("Loading user info...")
            .onAppear {
                showNextRoute(user: userViewModel.user)
            }
        
            .onChange(of: userViewModel.user) { user in
                showNextRoute(user: user)
            }
    }
    
    func showNextRoute(user: User?) {
        guard let user = user else { return }
        
        if shouldFillInfo(user) {
            coordinator.show(.setupInitialConfigs(user, completion))
            return
        }
        
        completion(user)
    }
    
    func shouldFillInfo(_ user: User) -> Bool {
        return (
            user.name.isEmpty ||
            user.username.isEmpty ||
            user.areaExpertise.isEmpty ||
            user.areaExpertise.isEmpty ||
            user.region.isEmpty
        )
    }
}
