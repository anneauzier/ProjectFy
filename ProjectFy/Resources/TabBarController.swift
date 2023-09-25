//
//  TabBarController.swift
//  ProjectFy
//
//  Created by Iago Ramos on 18/09/23.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    private var advertisementsCoordinator: Coordinator<AdvertisementsRouter>
    private var notificationsCoordinator: Coordinator<NotificationsRouter>
    private var groupsCoordinator: Coordinator<GroupsRouter>
    private var userCoordinator: Coordinator<UserRouter>
    
    private let user: User
    private let environmentObjects: [any ObservableObject]

    init(user: User, _ environmentObjects: (any ObservableObject)...) {
        self.user = user
        self.environmentObjects = environmentObjects

        advertisementsCoordinator = Coordinator(root: .advertisements(user))
        notificationsCoordinator = Coordinator(root: .notifications(user))
        groupsCoordinator = Coordinator(root: .groups(user))
        userCoordinator = Coordinator(root: .user(user))

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let advertisementsViewController = advertisementsCoordinator.navigationController
        let notificationsViewController = notificationsCoordinator.navigationController
        let groupsViewController = groupsCoordinator.navigationController
        let userViewController = userCoordinator.navigationController
        
        advertisementsViewController.tabBarItem = tabBarItem(title: "Home", image: "house", tag: 0)
        notificationsViewController.tabBarItem = tabBarItem(title: "Notifications", image: "bell", tag: 1)
        groupsViewController.tabBarItem = tabBarItem(title: "Group", image: "person.3", tag: 2)
        userViewController.tabBarItem = tabBarItem(title: "Profile", image: "person.fill", tag: 3)
        
        advertisementsCoordinator.start(environmentObjects: environmentObjects)
        notificationsCoordinator.start(environmentObjects: environmentObjects)
        groupsCoordinator.start(environmentObjects: environmentObjects)
        userCoordinator.start(environmentObjects: environmentObjects)
        
        groupsViewController.navigationBar.prefersLargeTitles = true
        
        self.setViewControllers([
            advertisementsViewController,
            notificationsViewController,
            groupsViewController,
            userViewController
        ], animated: false)
    }
    
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    private func tabBarItem(title: String, image: String, tag: Int) -> UITabBarItem {
        UITabBarItem(title: title, image: UIImage(systemName: image), tag: tag)
    }
}

extension TabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            if advertisementsCoordinator.navigationController.viewControllers.count > 1 {
                advertisementsCoordinator.popToRoot()
                return
            }
            
            guard let viewModel = environmentObjects.compactMap({ $0 as? AdvertisementsViewModel }).first else {
                return
            }
            
            viewModel.shouldScroll.toggle()
            
        case 2:
            groupsCoordinator.popToRoot()
            
        case 3:
            userCoordinator.popToRoot()
            
        default:
            return
        }
    }
}
