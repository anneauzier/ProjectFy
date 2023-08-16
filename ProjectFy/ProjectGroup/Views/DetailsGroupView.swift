//
//  DetailsGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 09/08/23.
//

import SwiftUI

struct DetailsGroupView: View {
    
    @EnvironmentObject var viewModel: GroupViewModel
    let detailsInfo: ProjectGroup
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Image("\(detailsInfo.avatar)")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Group {
                    Text("Group's name")
                    Text("\(detailsInfo.name)")
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.2))
                    
                    Text("Description")
                    Text("\(detailsInfo.description)")
                    
                    Divider()
                    
                    Text("Link")
            
                    Link("\(detailsInfo.link)", destination: URL(string: "\(detailsInfo.link)")!)
                }

                Divider()
                
                Text("Participants")
                
            }.padding(.horizontal)
            
            Spacer()

            FinalButtons()
            
        }.toolbar {
            NavigationLink(destination: EditDetailsGroup(groupID: detailsInfo.id)) {
                Text("Editar")
                    .foregroundColor(Color.black)
            }
        }
    }
}

struct DetailsGroupView_Previews: PreviewProvider {
    static var previews: some View {
        let previewGroup = ProjectGroup(
            id: "1213",
            name: "Adventure Game",
            description: "Lorem Ipsum is simply dummy text.",
            avatar: "Group2",
            adminID: "123456",
            positions: [],
            link: "https://trello.com/b/DwEhWYYJ/projectfy",
            tasks: [])
        
        DetailsGroupView(detailsInfo: previewGroup)
            .environmentObject(GroupViewModel(service: GroupMockupService()))
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
