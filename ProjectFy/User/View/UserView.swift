//
//  UserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 31/07/23.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    @State private var goEditUserView = false
    
    var presentUsersProfile: Bool = false
    let user: User
    
    var body: some View {
        NavigationView {
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

                    HStack(spacing: 4) {
                        Text(user.name)
                            .font(Font.title2)
                            .foregroundColor(.black)
                            .accessibilityLabel("Username: \(user.name)")
                        
                        Text(user.username)
                            .font(.body)
                            .foregroundColor(.editAdvertisementText)
                            .accessibilityLabel("@\(user.username)")
                    }.padding(.horizontal, 20)
                    
                    Group {
                        let imageVerify = user.available ? "checkmark.seal.fill" : "xmark.seal.fill"
                        
                        HStack(spacing: 4) {
                            Text(user.areaExpertise)
                                .font(.body)
                                .foregroundColor(.black)
                            
                            Circle()
                                .frame(width: 3)
                                .foregroundColor(.editAdvertisementText)
                            
                            Text(user.expertise.rawValue)
                                .font(.body)
                                .foregroundColor(.editAdvertisementText)
                                .accessibilityLabel("Knowledge Level \(user.expertise.rawValue)")
                            
                            Circle()
                                .frame(width: 3)
                                .foregroundColor(.editAdvertisementText)
                            
                            Image(systemName: imageVerify)
                                .foregroundColor(user.available ? Color.availableText : Color.unavailableText)
                        }
                        
                        HStack(spacing: 6) {
                            Image("location")

                            Text(user.region)
                                .font(.body)
                                .foregroundColor(.editAdvertisementText)
                        }.accessibilityElement(children: .combine)
                            .accessibilityLabel("Region \(user.region)")
                        
                    }.padding(.horizontal, 20)
                    
                    Divider()
                    
                    Group {
                        Text("Interests")
                            .font(Font.headline)
                            .foregroundColor(.black)
                        
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
                    }.padding(.horizontal, 20)
                    
                    UserAdvertisement(user: user)
                    
                }
            } .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("My Profile")

            .toolbar {
                if !presentUsersProfile {
                    Menu {
                        Button {
                            goEditUserView.toggle()
                        } label: {
                            Label("Edit profile", systemImage: "square.and.pencil")
                        }
                        
                        Button {
                            // LÓGICA PARA LOGOUT
                        } label: {
                            Label("Log out", systemImage: "iphone.and.arrow.forward")
                        }
                        Button(role: .destructive) {
                            Haptics.shared.impact(.rigid)
                            // LÓGICA PARA DELETAR CONTA
                        } label: {
                            Label("Delete Account", systemImage: "person.crop.circle.badge.xmark")
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                            .imageScale(.large)
                            .accessibilityLabel("Edital Perfil")
                    }.sheet(isPresented: $goEditUserView, content: {
                        EditUserView(editingUser: user, viewModel: viewModel)
                    })
                }
            }
        }
    }
}

struct UserAdvertisement: View {
    
    let user: User
    //    let advertisement: Advertisement
    
    var body: some View {
        VStack(alignment: .center) {
            
            Divider()
            Text("Meus anúncios")
                .foregroundColor(.black)
                .bold()
            Divider()
            
            //        AdView(owner: <#T##User#>,
            //        advertisement: <#T##Advertisement#>,
            //        editingID: <#T##Binding<String?>#>,
            //        editAdvertisement: <#T##Binding<Bool>#>,
            //        selectedPositionToPresent: <#T##Binding<ProjectGroup.Position?>#>,
            //        presentPositionSheet: <#T##Binding<Bool>#>)
            
        }
    }
}

//                if !presentUsersProfile {
//                    Button {
//                        goEditUserView.toggle()
//                    } label: {
//                        Image(systemName: "ellipsis.circle")
//                            .imageScale(.large)
//                            .accessibilityLabel("Edital Perfil")
//                    }
//                }
//            }.sheet(isPresented: $goEditUserView, content: {
//                EditUserView(editingUser: user, viewModel: viewModel)
