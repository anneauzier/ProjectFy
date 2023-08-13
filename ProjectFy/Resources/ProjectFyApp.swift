//
//  ProjectFyApp.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 26/07/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct ProjectFyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    @StateObject var userViewModel = UserViewModel(service: UserService())
    @StateObject var advertisementsViewModel = AdvertisementsViewModel(service: AdvertisementService())

    var body: some Scene {
        WindowGroup {
            if authenticationViewModel.isAuthenticated() {
                HomeView()
                    .environmentObject(advertisementsViewModel)
                    .environmentObject(userViewModel)
                
                    .onAppear {
                        guard let userID = authenticationViewModel.getAuthenticatedUser()?.uid else {
                            return
                        }
                        
                        userViewModel.setUser(with: userID)
                    }
            } else {
                SignInView()
                    .environmentObject(authenticationViewModel)
                    .environmentObject(userViewModel)
            }
        }
    }
}
