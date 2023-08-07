//
//  UserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 31/07/23.
//

import SwiftUI

struct UserView: View {
    
    @State private var goEditUserView = false
    @ObservedObject var viewModel: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Button {
                    goEditUserView.toggle()
                } label: {
                    Text("Editar")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .accessibilityLabel("Edital Perfil")

                }.sheet(isPresented: $goEditUserView, content: {
                    EditUserView(viewModel: viewModel, editingID: viewModel.users[0].id)
                })
                Image("\(viewModel.users[0].avatar)")
                    .aspectRatio(contentMode: .fit)
                    .accessibilityLabel("Foto de perfil")
            }
            
            Divider()
                .padding(.top, -20)
            
            Group {
                Text("\(viewModel.availability)")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                HStack {
                    Text("\(viewModel.users[0].name)")
                        .font(.title)
                        .bold()
                        .accessibilityLabel("Username \(viewModel.users[0].name)")

                    Text("\(viewModel.users[0].username)")
                        .foregroundColor(.gray)
                        .bold()
                        .accessibilityLabel("@\(viewModel.users[0].username)")
                }
                
                HStack {
                    Text("\(viewModel.users[0].areaExpertise)")
                        .bold()
                    
                    Circle()
                        .frame(width: 5)
                        .foregroundColor(.gray)
                    
                    Text("\(viewModel.users[0].expertise.rawValue)")
                        .foregroundColor(.gray)
                        .bold()
                        .accessibilityLabel("Nível de Conhecimento \(viewModel.users[0].expertise.rawValue)")
                }
                
                HStack {
                    Image(systemName: "mappin")
                    Text("\(viewModel.users[0].region)")
                        .foregroundColor(.gray)
                        .bold()
                }.accessibilityElement(children: .combine)
                .accessibilityLabel("Região \(viewModel.users[0].region)")
            }
            
            Divider()
            
            Group {
                Text("Interesses:")
                    .foregroundColor(.gray)
                    .bold()
                
                HStack(spacing: 8) {
                    let splitInterests = viewModel.users[0].interestTags.split(separator: ",")
                    
                    ForEach(splitInterests, id: \.self) { interest in
                        Text("\(interest.trimmingCharacters(in: .whitespacesAndNewlines))")
                            .font(.caption)
                            .padding(7)
                            .foregroundColor(.white)
                            .bold(true)
                            .lineLimit(0)
                            .background(Capsule().fill(.gray))
                    }
                }
                
                Divider()
                
                Text("Meus anúncios")
                    .foregroundColor(.black)
                    .bold()
                
                Spacer()
                
            }
        }.padding(.horizontal, 20)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UserViewModel(service: UserMockupService())
        UserView(viewModel: viewModel)
    }
}
