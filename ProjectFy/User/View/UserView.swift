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

    let user: User

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Button {
                    Haptics.shared.selection()
                    goEditUserView.toggle()
                } label: {
                    Text("Editar")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .accessibilityLabel("Edital Perfil")

                }.sheet(isPresented: $goEditUserView, content: {
                    EditUserView(editingUser: user, viewModel: viewModel)
                })
                
                Image(user.avatar)
                    .aspectRatio(contentMode: .fit)
                    .accessibilityLabel("Foto de perfil")
            }
            
            Divider()
                .padding(.top, -20)
            
            Group {
                let availability = user.available ? "Available" : "Unvailable"
                
                Text(availability)
                    .foregroundColor(.gray)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                HStack {
                    Text(user.name)
                        .font(.title)
                        .bold()
                        .accessibilityLabel("Username \(user.name)")

                    Text(user.username)
                        .foregroundColor(.gray)
                        .bold()
                        .accessibilityLabel("@\(user.username)")
                }
                
                HStack {
                    Text(user.areaExpertise)
                        .bold()
                    
//                    Image("\(viewModel.users[0].avatar)")
                        .aspectRatio(contentMode: .fit)
                        .accessibilityLabel("Foto de perfil")
                    
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
                .accessibilityLabel("Region \(user.region)")
            }
            
            Divider()
            
            Group {
                Text("Interesses:")
                    .foregroundColor(.gray)
                    .bold()
                
                HStack(spacing: 8) {
                    let splitInterests = user.interestTags.split(separator: ",")
                    
                    ForEach(splitInterests, id: \.self) { interest in
                        // TODO: trocar o bold por um que esteja disponível em outras versões do iOS
                        Text("\(interest.trimmingCharacters(in: .whitespacesAndNewlines))")
                            .font(.caption)
                            .padding(7)
                            .foregroundColor(.white)
    //                            .bold(true)
                            .lineLimit(0)
                            .background(Capsule().fill(.gray))
                    }
                }.padding(.horizontal, 20)
            }
//            .toolbar {
//                if !presentUsersProfile {
//                    Button {
//                        goEditUserView.toggle()
//                    } label: {
//                        Text("Editar")
//                            .font(.headline)
//                            .foregroundColor(.gray)
//                            .frame(maxWidth: .infinity, alignment: .trailing)
//                            .accessibilityLabel("Edital Perfil")
//
//                    }.sheet(isPresented: $goEditUserView, content: {
//                        EditUserView(viewModel: viewModel, editingID: viewModel.users[0].id)
//                    })
////                }
//            }
        }
    }
}
