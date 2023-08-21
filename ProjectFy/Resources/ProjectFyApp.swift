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
            if authenticationViewModel.isAuthenticated {
                HomeView(isNewUser: $isNewUser)
                
                .onAppear {
                    guard let user = authenticationViewModel.getAuthenticatedUser() else { return }
                    
                    userViewModel.setUser(with: user.uid)
                    groupViewModel.setUser(with: user.uid)
                }
                
                .environmentObject(advertisementsViewModel)
                .environmentObject(userViewModel)
                .environmentObject(groupViewModel)
                .environmentObject(notificationsViewModel)
            } else {
                SignInView(isNewUser: $isNewUser)
                    .environmentObject(authenticationViewModel)
                    .environmentObject(userViewModel)
            }
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
        guard let currentUser = Auth.auth().currentUser, let token = fcmToken else { return }
        self.saveFCMToken(currentUser: currentUser, token: token)
    }
    
    private func saveFCMToken(currentUser: FirebaseAuth.User, token: String) {
        let tokensCollection = DBCollection(collectionName: "tokens")
        
        tokensCollection.addSnapshotListener { (tokens: [FCMToken]?) in
            let userID = currentUser.uid
            
            do {
                guard var userTokens = tokens?.first(where: { $0.userID == userID }) else {
                    let tokens = FCMToken(userID: currentUser.uid, tokens: [token])
                    try tokensCollection.create(tokens, with: userID)
                    
                    return
                }
                
                if !userTokens.tokens.contains(token) {
                    userTokens.tokens.append(token)
                    try tokensCollection.update(userTokens, with: userID)
                }
            } catch {
                print("Cannot save FCMToken: \(error.localizedDescription)")
            }
        }
    }
    
    private struct FCMToken: Hashable, Codable {
        let userID: String
        var tokens: [String]
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case tokens
        }
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
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {}

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        completionHandler()
    }
}
