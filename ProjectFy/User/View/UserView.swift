//
//  UserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 31/07/23.
//

import SwiftUI

struct UserView: View {

    @State private var goEditUserView = false
    @ObservedObject var viewModel: EditUserViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Button {
                    goEditUserView.toggle()
                } label: {
                    Text("Editar")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .bold()
                        .padding(.leading, 300)
                }.sheet(isPresented: $goEditUserView, content: {
                    EditUserView(viewModel: viewModel)
                })

                Circle()
                    .frame(width: 96)
                    .foregroundColor(.gray)
            }
            
            Divider()
                .padding(.top, -20)
            
            Group {
                Text("Disponível")
                    .foregroundColor(.gray)
                    .bold()
                    .font(.caption)
                    .padding(.leading, 280)
                
                HStack {
                    Text("\(viewModel.oldUsername)")
                        .font(.title)
                        .bold()
                    Text("@arrudajade")
                        .foregroundColor(.gray)
                        .bold()
                }
                
                HStack {
                    Text("\(viewModel.areaExpertise)")
                        .bold()
                    
                    Circle()
                        .frame(width: 5)
                        .foregroundColor(.gray)
                    
                    Text("\(User.Expertise.beginner.rawValue)")
                        .foregroundColor(.gray)
                        .bold()
                }
                
                HStack {
                    Image(systemName: "mappin")
                    Text("\(User.mock[0].region)")
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
//                    ForEach(viewModel.interests, id: \.self) { interest in
                    Text("\(viewModel.interests)")
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
            
        }.padding(.horizontal, 20)
    }
}

 struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EditUserViewModel()
        UserView(viewModel: viewModel)
    }
 }

//   Button(action: {
//           print("Circular Button tapped")
//            }) {
//        Text("Tap me")
//                .frame(width: 130, height: 130)
//                .foregroundColor(Color.white)
//                .background(Color.green)
//                .clipShape(Circle())
//        }
