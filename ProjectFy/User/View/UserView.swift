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
                    
                    Image(user.avatar)
                        .aspectRatio(contentMode: .fit)
                        .accessibilityLabel("Foto de perfil")
                    
                    Divider()
                        .padding(.top, -20)
                    
                    Group {
                        let availability = user.available ? "Available" : "Unavailable"
                        
                        Text(availability)
                            .foregroundColor(.gray)
                            .font(.headline)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        HStack {
                            Text(user.name)
                                .font(.title)
                                .bold()
                                .accessibilityLabel("Username: \(user.name)")
                            
                            Text(user.username)
                                .foregroundColor(.gray)
                                .bold()
                                .accessibilityLabel("@\(user.username)")
                        }
                        
                        HStack {
                            Text(user.areaExpertise)
                                .bold()
                            
                            Circle()
                                .frame(width: 5)
                                .foregroundColor(.gray)
                            
                            Text(user.expertise.rawValue)
                                .foregroundColor(.gray)
                                .bold()
                                .accessibilityLabel("Nível de Conhecimento \(user.expertise.rawValue)")
                        }
                        
                        HStack {
                            Image(systemName: "mappin")
                            Text(user.region)
                                .foregroundColor(.gray)
                                .bold()
                        }.accessibilityElement(children: .combine)
                            .accessibilityLabel("Região \(user.region)")
                    }
                    
                    Divider()
                    
                    Group {
                        Text("Interesses:")
                            .foregroundColor(.gray)
                            .bold()
                        
                        HStack(spacing: 8) {
                            let splitInterests = user.interestTags.split(separator: ",")
                            
                            ForEach(splitInterests, id: \.self) { interest in
                                Text("\(interest.trimmingCharacters(in: .whitespacesAndNewlines))")
                                    .font(.caption)
                                    .padding(7)
                                    .foregroundColor(.white)
                                    .lineLimit(0)
                                    .background(Capsule().fill(.gray))
                            }
                        }
                    }
                        
                    UserAdvertisement(user: user)

                }
                .padding(.horizontal, 20)
            }
            .toolbar {
                if !presentUsersProfile {
                    Button {
                        goEditUserView.toggle()
                    } label: {
                        Text("Editar")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .accessibilityLabel("Edital Perfil")
                    }
                }
            }.sheet(isPresented: $goEditUserView, content: {
                EditUserView(editingUser: user, viewModel: viewModel)
            })
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
