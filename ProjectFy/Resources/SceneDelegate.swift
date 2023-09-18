//
//  SceneDelegate.swift
//  ProjectFy
//
//  Created by Iago Ramos on 14/09/23.
//

import Foundation
import UIKit
import FirebaseAuth

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var authenticationViewModel = AuthenticationViewModel()
    var userViewModel = UserViewModel(service: UserService())
    var advertisementsViewModel = AdvertisementsViewModel(service: AdvertisementService())
    var groupViewModel = GroupViewModel(service: GroupService())
    var notificationsViewModel = NotificationsViewModel(service: NotificationService())
    
    var coordinator: Coordinator<SignInRouter>?
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        coordinator = Coordinator(root: .signin(goToAppFlow))
        
        coordinator?.start(environmentObjects: [
            authenticationViewModel,
            userViewModel,
            advertisementsViewModel,
            groupViewModel,
            notificationsViewModel
        ])
        
        window = UIWindow(windowScene: scene)
        setRootViewController(coordinator?.navigationController)
    }
    
    func setRootViewController(_ viewController: UIViewController?) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    func goToAppFlow(userID: String) {
        coordinator?.show(.waitingForUserInfo(userViewModel) { [weak self] user in
            guard let self = self else { return }
            
            let tabBarController = TabBarController(user: user,
                                                    self.userViewModel,
                                                    self.advertisementsViewModel,
                                                    self.groupViewModel,
                                                    self.notificationsViewModel)
            
            self.setRootViewController(tabBarController)
            coordinator = nil
        })
    }
}
