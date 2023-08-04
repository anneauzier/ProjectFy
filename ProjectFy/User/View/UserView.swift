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

                }.sheet(isPresented: $goEditUserView, content: {
                    EditUserView(viewModel: viewModel)
                })
                Image("\(viewModel.user.avatar)")
                    .aspectRatio(contentMode: .fit)
            }
            
            Divider()
                .padding(.top, -20)
            
            Group {
                Text("\(viewModel.availability)")
                    .foregroundColor(.gray)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                HStack {
                    Text("\(viewModel.user.name)")
                        .font(.title)
                        .bold()
                    Text("\(User.mock[0].username)")
                        .foregroundColor(.gray)
                        .bold()
                }
                
                HStack {
                    Text("\(viewModel.user.areaExpertise)")
                        .bold()
                    
                    Circle()
                        .frame(width: 5)
                        .foregroundColor(.gray)
                    
                    Text("\(viewModel.user.expertise.rawValue)")
                        .foregroundColor(.gray)
                        .bold()
                }
                
                HStack {
                    Image(systemName: "mappin")
                    Text("\(viewModel.user.region)")
                        .foregroundColor(.gray)
                        .bold()
                }
            }
            
            Divider()
            
            Group {
                Text("Interesses:")
                    .foregroundColor(.gray)
                    .bold()
                
                HStack(spacing: 8) {
                    let splitInterests = viewModel.user.interestTags.split(separator: ",")
                    
                    ForEach(splitInterests, id: \.self) { interest in
                        Text("\(interest.trimmingCharacters(in: .whitespacesAndNewlines))")
                            .font(.caption)
                            .padding(7)
                            .foregroundColor(.white)
                            .bold(true)
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
        let viewModel = UserViewModel(user: User.mock[0])
        UserView(viewModel: viewModel)
    }
}
