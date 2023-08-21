//
//  DetailsGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 09/08/23.
//

import SwiftUI

struct DetailsGroupView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    let group: ProjectGroup
    
    @State private var goEditGroupView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image("\(group.avatar)")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Group {
                    Text("Group name")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("\(group.name)")
                        .font(.body)
                        .foregroundColor(.black)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.2))
                    
                    Text("Group description")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("\(group.description)")
                        .font(.body)
                        .foregroundColor(.black)
                    
                    Divider()
                    
                    Text("Link for chat or/and meetings")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    if let url = URL(string: group.link) {
                        Link("\(group.link)", destination: url)
                    } else {
                        Text("No link available")
                            .font(.body)
                    }
                }

                Divider()
                
                Text("Participants")
                    .font(.headline)
                    .foregroundColor(.black)
                
                // AJEITAR ISSO AQUI
                RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                    UserInfo(user: group.admin, size: 49, nameColor: .white)
                    // TRATAR ESSA RESPONSIVIDADE DEPOIS
                        .padding(.trailing, 40)
                        .removePadding()
                }.frame(height: 88)
                    .padding(.bottom, 40)
                
            }.padding(.horizontal, 20)
            
            Spacer()

            FinalButtons()
            
        }.toolbar {
            Button(action: {
                goEditGroupView.toggle()
            }, label: {
                Text("Edit")
                    .foregroundColor(.black)
            }).sheet(isPresented: $goEditGroupView) {
                EditDetailsGroup(group: group, viewModel: viewModel)
            }
        }.onAppear {
            TabBarModifier.hideTabBar()
        }
    }
}

extension DetailsGroupView {
    
    struct FinalButtons: View {
        var body: some View {
            VStack {
                Button {
                    print("FINALIZAR GRUPO")
                } label: {
                    RoundedRectangleContent(cornerRadius: 16, fillColor: Color.textColorBlue) {
                        Text("Finalize project")
                            .font(Font.headline)
                            .foregroundColor(.white)
                    }
                }.frame(width: UIScreen.main.bounds.width - 40, height: 56)
                
                Button {
                    print("SAIR DO GRUPOOO")
                } label: {
                    RoundedRectangleContent(cornerRadius: 16, fillColor: Color.unavailableText) {
                        Text("Exit group")
                            .font(Font.headline)
                            .foregroundColor(.white)
                    }
                }.frame(width: UIScreen.main.bounds.width - 40, height: 56)
            }
        }
    }
}
