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
    
    private let user: User
    private let environmentObjects: [any ObservableObject]

    init(user: User, _ environmentObjects: (any ObservableObject)...) {
        self.user = user
        self.environmentObjects = environmentObjects

        advertisementsCoordinator = Coordinator(root: .advertisements(user))

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
        
        let advertisementsBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        advertisementsViewController.tabBarItem = advertisementsBarItem
        
        advertisementsCoordinator.start(environmentObjects: environmentObjects)
        
        self.setViewControllers([
            advertisementsViewController
        ], animated: false)
    }
    
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
