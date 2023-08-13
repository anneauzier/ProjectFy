//
//  HomeView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        if let user = userViewModel.user {
            TabBarView(user: user)
        } else {
            LoadingUserInfo()
        }
    }
    
    struct LoadingUserInfo: View {
        var body: some View {
            Text("Loading user info...")
        }
    }
}

fileprivate struct TabBarView: View {
    let user: User
    
    var body: some View {
        TabView {
            AdvertisementsView(user: user)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            UserView(user: user)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}
