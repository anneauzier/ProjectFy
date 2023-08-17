//
//  ProjectFyApp.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 26/07/23.
//

import SwiftUI

@main
struct ProjectFyApp: App {
    @StateObject var groupViewModel = GroupViewModel(service: GroupMockupService())
    @StateObject var advertisementsViewModel = AdvertisementsViewModel(service: AdvertisementMockupService())
    @StateObject var userViewModel = UserViewModel(service: UserMockupService())

    var body: some Scene {
        WindowGroup {
            TabBarView()
                .environmentObject(groupViewModel)
                .environmentObject(advertisementsViewModel)
                .environmentObject(userViewModel)

                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
