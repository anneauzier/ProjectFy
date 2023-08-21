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
            VStack(alignment: .leading, spacing: 14) {
                Image("\(group.avatar)")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Group {
                    Text("Group's name")
                    Text("\(group.name)")
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.2))
                    
                    Text("Description")
                    Text("\(group.description)")
                    
                    Divider()
                    
                    Text("Link")
                    
                    if let url = URL(string: group.link) {
                        Link("\(group.link)", destination: url)
                    } else {
                        Text("Sem link disponível")
                    }
                }

                Divider()
                
                Text("Participants")
                
            }.padding(.horizontal)
            
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
        }
    }
}

extension DetailsGroupView {
    
    struct FinalButtons: View {
        var body: some View {
            VStack(alignment: .center) {
                Button {
                    print("SAI")
                } label: {
                    Text("Sair do grupo")
                        .padding()
                        .background(Color.black)
                }
                
                Button {
                    print("FINALIZEI")
                } label: {
                    Text("Finalizar projeto")
                        .padding()
                        .background(Color.black)
                }
            }
        }
    }
}
