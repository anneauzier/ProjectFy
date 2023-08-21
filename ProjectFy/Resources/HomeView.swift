//
//  HomeView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel
    
    @Binding var isNewUser: Bool?
    
    var body: some View {
        if let user = userViewModel.user {
            TabBarView(user: user, isNewUser: $isNewUser)
                .onAppear {
                    notificationsViewModel.startListening(with: user.id)
                }
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
                
                Notifications(user: user)
                    .tabItem { Label("Notifications", systemImage: "bell") }
                    
                GroupView(user: user)
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
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Hi, stranger! We need some information from you :D")
                        .font(Font.largeTitle.bold())
                        .padding(.top, 16)
                    
                    Text("Don't worry, you can change these informations later...")
                        .foregroundColor(.gray)
                        .font(Font.headline)
                        .padding(.top, 20)

                }.frame(width: UIScreen.main.bounds.width - 40)
                
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
            VStack(alignment: .center) {
                Text("    All ready? \nLet's group!:D")
                    .font(Font.largeTitle.bold())
                    .frame(width: UIScreen.main.bounds.width - 97)
                    .padding(.bottom, 40)
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: UIScreen.main.bounds.width - 144, height: 1)
                    .background(Color.gray.opacity(0.3))
                    .padding(.bottom, 44)
                
                Button {
                    viewModel.editUser(user)
                    isNewUser = nil
                } label: {
                    RoundedRectangleContent(cornerRadius: 16, fillColor: .blue) {
                        Text("Let's go!")
                            .font(Font.headline)
                            .foregroundColor(.white)
                    }
                }.frame(width: UIScreen.main.bounds.width - 208, height: 56)
            }
        }
    }
}
