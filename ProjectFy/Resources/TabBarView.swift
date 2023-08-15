//
//  TabBarView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView {
            AdvertisementsView()
                .tabItem { Label("Home", systemImage: "house") }
            GroupView()
                .tabItem { Label("Group", systemImage: "person.3") }
            UserView()
                .tabItem { Label("Profile", systemImage: "person.fill") }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(UserViewModel(service: UserMockupService()))
            .environmentObject(AdvertisementsViewModel(service: AdvertisementMockupService()))
            .environmentObject(GroupViewModel(service: GroupMockupService()))
    }
}
