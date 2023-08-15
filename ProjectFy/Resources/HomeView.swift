//
//  HomeView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var isNewUser: Bool?
    
    var body: some View {
        if let user = userViewModel.user {
            TabBarView(user: user, isNewUser: $isNewUser)
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
    @Binding var isNewUser: Bool?
    
    var body: some View {
//        if let isNewUser = isNewUser, isNewUser {
//            Teste(user: user, isNewUser: $isNewUser)
//        } else {
            TabView {
                AdvertisementsView(user: user)
                    .tabItem { Label("Home", systemImage: "house") }
                
                GroupView()
                    .tabItem { Label("Group", systemImage: "person.3") }
                
                UserView(user: user)
                    .tabItem { Label("Profile", systemImage: "person.fill") }
            }
//        }
    }
}

fileprivate struct Teste: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    let user: User
    @Binding var isNewUser: Bool?
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Hi, stranger! We need some information from you :D")
                    .font(.title)
                    .padding(.top, 4)
                
                Text("Don't worry, you can change these informations later...")
                    .foregroundColor(.gray)
                    .padding(.top, 14)
            }
            .padding(.horizontal, 16)
            
            EditUserView(editingUser: user, isNewUser: true, viewModel: userViewModel)
        }
        
    }
}
