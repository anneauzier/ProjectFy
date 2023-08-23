//
//  UserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 31/07/23.
//

import SwiftUI

struct UserView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var goEditUserView = false
    @State private var showDeleteAlert = false
    @State private var presentSignIn = false
    
    var presentUsersProfile: Bool = false
    let user: User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(maxWidth: .infinity)
                        .frame(height: 100)
                        .foregroundColor(.roleBackground)
                    
                    Image(user.avatar)
                        .resizable()
                        .frame(width: 90, height: 90)
                        .aspectRatio(contentMode: .fill)
                        .accessibilityLabel("Profile photo")
                        .background(
                            Circle()
                                .fill(.white)
                                .frame(width: 110, height: 110)
                        )
                        .padding(.leading, 30)
                        .padding(.top, 40)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 4) {
                        let imageVerify = user.available ? "checkmark.seal.fill" : "xmark.seal.fill"
                        
                        Text(user.name)
                            .font(Font.title2.bold())
                            .foregroundColor(.backgroundRole)
                            .accessibilityLabel("Username: \(user.name)")
                        
                        Image(systemName: imageVerify)
                            .foregroundColor(user.available ? Color.availableText : Color.unavailableText)
                        
                        Circle()
                            .frame(width: 3)
                            .foregroundColor(.editAdvertisementText)
                        
                        Text(user.username)
                            .font(.body)
                            .foregroundColor(.editAdvertisementText)
                            .accessibilityLabel("@\(user.username)")
                    }
                    .padding(.top, 15)
                    
                    HStack(spacing: 4) {
                        Text(user.areaExpertise)
                            .font(.body)
                            .foregroundColor(.backgroundRole)
                        
                        Circle()
                            .frame(width: 3)
                            .foregroundColor(.editAdvertisementText)
                        
                        Text(user.expertise.rawValue)
                            .font(.body)
                            .foregroundColor(.editAdvertisementText)
                            .accessibilityLabel("Knowledge Level \(user.expertise.rawValue)")
                    }
                    
                    HStack(spacing: 6) {
                        Image("location")
                        
                        Text(user.region)
                            .font(.body)
                            .foregroundColor(.editAdvertisementText)
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Region \(user.region)")
                    
                }
                .padding(.horizontal, 20)
                
                Divider()
                    .padding(.top, 12)
                
                VStack(alignment: .leading) {
                    Text("Interests")
                        .font(Font.headline)
                        .foregroundColor(.backgroundRole)
                        .padding(.top, 12)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            let splitInterests = user.interestTags.split(separator: ",")
                            ForEach(splitInterests, id: \.self) { interest in
                                Text("\(interest.trimmingCharacters(in: .whitespacesAndNewlines))")
                                    .padding(5)
                                    .font(.callout.bold())
                                    .foregroundColor(.textColorBlue)
                                    .lineLimit(0)
                                    .background(Color.backgroundTextBlue)
                                    .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 15)
                
                UserAdvertisement(user: user)
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        
        .toolbar {
            if !presentUsersProfile {
                Menu {
                    Button {
                        goEditUserView.toggle()
                    } label: {
                        Label("Edit profile", systemImage: "square.and.pencil")
                    }
                    
                    Button {
                        authenticationViewModel.signOut()
                    } label: {
                        Label("Log out", image: "logout")
                    }
                    Button(role: .destructive) {
                        Haptics.shared.impact(.rigid)
                        showDeleteAlert.toggle()
                    } label: {
                        Label("Delete Account", systemImage: "person.crop.circle.badge.xmark")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .imageScale(.large)
                        .accessibilityLabel("Edital Perfil")
                }.sheet(isPresented: $goEditUserView, content: {
                    EditUserView(editingUser: user, viewModel: userViewModel)
                })
            }
        }
        
        .alert("Do you really want to delete your account?", isPresented: $showDeleteAlert) {
            Button(role: .cancel) {
                showDeleteAlert.toggle()
            } label: {
                Text("No, I don't")
            }
            
            Button(role: .destructive) {
                Haptics.shared.notification(.success)
                
                showDeleteAlert.toggle()
                presentSignIn.toggle()
            } label: {
                Text("Yes, I do")
            }
        } message: {
            Text("Your account and all information, groups and your project announcements will be permanently deleted.")
                .multilineTextAlignment(.leading)
        }
        
        .fullScreenCover(isPresented: $presentSignIn) {
            NavigationView {
                SignInView(isDeletingAccount: true, isNewUser: .constant(false))
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                presentSignIn.toggle()
                            } label: {
                                Label("close", systemImage: "xmark")
                                    .labelStyle(.iconOnly)
                            }
                        }
                    }
            }
        }
    }
}

struct UserAdvertisement: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    
    let user: User
    
    var body: some View {
        VStack(alignment: .center) {
            
            Divider()
            
            Text("My projects")
                .font(Font.headline)
                .foregroundColor(.backgroundRole)
                .padding(.vertical, 12)
            
            Divider()
            
            if advertisementsViewModel.advertisements.isEmpty {
                Connectivity(image: Image("emptyAd"),
                             title: "Looks like you haven't \nshared your project \nideas yet :(",
                             description: "You can start sharing your project \nideas by taping “+” on the home screen",
                             heightPH: 0.4)
            } else {
                UserInfo(user: user, size: 49, nameColor: .backgroundRole)
                    .frame(maxWidth: UIScreen.main.bounds.width - 40, alignment: .leading)
                    .padding(.top, 6)
                
                ForEach(advertisementsViewModel.getAdvertisements(from: user.id), id: \.self) { advertisement in
                    AdView.AdInfo(
                        user: user,
                        advertisement: advertisement,
                        updateAdvertisements: .constant(false),
                        selectedPosition: .constant(nil),
                        presentSheet: .constant(false)
                    )
                }
            }
        }
    }
}
