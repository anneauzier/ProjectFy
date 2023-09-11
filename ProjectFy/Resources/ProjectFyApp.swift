//
//  ProjectFyApp.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 26/07/23.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth
import Firebase
import UserNotifications

@main
struct ProjectFyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var authenticationViewModel = AuthenticationViewModel()
    @StateObject var userViewModel = UserViewModel(service: UserService())
    @StateObject var advertisementsViewModel = AdvertisementsViewModel(service: AdvertisementService())
    @StateObject var groupViewModel = GroupViewModel(service: GroupService())
    @StateObject var notificationsViewModel = NotificationsViewModel(service: NotificationService())

    @State var isNewUser: Bool? = true
    
    init() {
        UIApplication.shared.addTapGestureRecognizer()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authenticationViewModel.isAuthenticated {
                    HomeView(isNewUser: $isNewUser)
                    
                    .onAppear {
                        guard let user = authenticationViewModel.getAuthenticatedUser() else { return }
                        
                        userViewModel.setUser(with: user.uid)
                        groupViewModel.setUser(with: user.uid)
                    }
                } else {
                    SignInView(isNewUser: $isNewUser)
                }
            }
                .environmentObject(authenticationViewModel)
                .environmentObject(advertisementsViewModel)
                .environmentObject(userViewModel)
                .environmentObject(groupViewModel)
                .environmentObject(notificationsViewModel)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let gcmMessageIDKey = "gcm.message_id"
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
        
        application.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

extension AppDelegate: MessagingDelegate {

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        MessagingService.shared.token = fcmToken
        print(fcmToken)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([[.banner, .badge, .sound]])
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        
        let teste = deviceToken.map { data in
            String(format: "$02.2hhx", data)
        }
        
        print("data: \(teste.joined())")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        completionHandler()
    }
}
