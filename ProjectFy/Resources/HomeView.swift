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
        if let isNewUser = isNewUser, isNewUser {
            SetupInitialConfigs(user: user, isNewUser: $isNewUser)
        } else {
            TabView {
                AdvertisementsView(user: user)
                    .tabItem { Label("Home", systemImage: "house") }
                
                GroupView()
                    .tabItem { Label("Group", systemImage: "person.3") }
                
                UserView(user: user)
                    .tabItem { Label("Profile", systemImage: "person.fill") }
            }
        }
    }
}

fileprivate struct SetupInitialConfigs: View {
    @State var user: User
    @Binding var isNewUser: Bool?
    
    @State var canContinue = false
    
    init(user: User, isNewUser: Binding<Bool?>) {
        self._user = State(initialValue: user)
        self._isNewUser = isNewUser
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Hi, stranger! We need some information from you :D")
                        .font(.title)
                        .padding(.top, 4)
                    
                    Text("Don't worry, you can change these informations later...")
                        .foregroundColor(.gray)
                        .padding(.top, 14)
                }
                .padding(.horizontal, 16)
                
                SetupUserInfo(user: $user, canContinue: $canContinue, isNewUser: true)
            }
            
            .toolbar {
                NavigationLink {
                    StartView(user: user, isNewUser: $isNewUser)
                } label: {
                    Text("Next")
                }
                .disabled(!canContinue)
            }
        }
        
    }
    
    private struct StartView: View {
        @EnvironmentObject var viewModel: UserViewModel
        
        let user: User
        @Binding var isNewUser: Bool?
        
        var body: some View {
            VStack {
                Spacer()
                
                Text("All ready, let's group! :D")
                    .font(.system(.title))
                
                Spacer()
                
                Button {
                    viewModel.editUser(user)
                    isNewUser = nil
                } label: {
                    RoundedRectangleContent(cornerRadius: 16, fillColor: .black) {
                        Text("Let's go!")
                            .foregroundColor(.white)
                            .padding(.vertical, 15)
                    }
                }
                .frame(height: 56)
            }
            .padding(.horizontal, 20)
        }
    }
}
