//
//  HomeView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var advertisementViewModel: AdvertisementsViewModel
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel
    
    var body: some View {
        if let user = userViewModel.user {
            TabBarView(user: user, isNewUser: $authenticationViewModel.isNewUser)
                .onAppear {
                    MessagingService.shared.userID = user.id
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
    @EnvironmentObject var groupViewModel: GroupViewModel
    
    let user: User
    @Binding var isNewUser: Bool
    
    var getUserInfo: Bool {
        user.name.isEmpty ||
        user.areaExpertise.isEmpty ||
        user.region.isEmpty
    }
    
//    @StateObject var AdvertisementsCoordinator

    var body: some View {
        if isNewUser, getUserInfo {
            SetupInitialConfigs(user: user, isNewUser: $isNewUser)
        } else {
            TabView {
                AdvertisementsView(user: user)
                    .tabItem { Label("Home", systemImage: "house") }
                
                Notifications(user: user)
                    .tabItem { Label("Notifications", systemImage: "bell") }
                    
                GroupView(user: user)
                    .tabItem { Label("Group", systemImage: "person.3") }
                
                NavigationView {
                    UserView(user: user)
                }
                .tabItem { Label("Profile", systemImage: "person.fill") }
            }.tint(.textColorBlue)
        }
    }
}

fileprivate struct SetupInitialConfigs: View {
    @State var user: User

    @Binding var isNewUser: Bool
    @State var canContinue = false
    
    init(user: User, isNewUser: Binding<Bool>) {
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
                        .font(Font.headline)
                        .foregroundColor(.editAdvertisementText)
                        .padding(.top, 15)

                }
                .frame(width: UIScreen.main.bounds.width - 33)
                
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
        @Binding var isNewUser: Bool
        
        var body: some View {
            VStack(alignment: .center, spacing: 40) {
                Spacer()
                
                Text("    All ready? \nLet's \("grooup!".colored(with: .textColorBlue))")
                    .font(Font.largeTitle.bold())
                    .frame(width: UIScreen.main.bounds.width - 97)
                    
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: UIScreen.main.bounds.width - 144, height: 1)
                    .background(Color.gray.opacity(0.3))
                    
                Button {
                    viewModel.editUser(user)
                    isNewUser = false
                } label: {
                    RoundedRectangleContent(cornerRadius: 8, fillColor: .textColorBlue) {
                        Text("Let's go!")
                            .font(Font.headline)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 208, height: 56)
                
                Spacer()
            }.background(
                Image("LasPageLog")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width)
                    .edgesIgnoringSafeArea(.all)
            )
        }
    }
}
