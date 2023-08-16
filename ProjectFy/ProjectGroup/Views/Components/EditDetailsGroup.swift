//
//  EditDetailsGroup.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 10/08/23.
//

import SwiftUI

struct EditDetailsGroup: View {
    
    @EnvironmentObject var viewModel: GroupViewModel
    @State var groupInfo = ProjectGroup(id: "",
                                        name: "",
                                        description: "",
                                        avatar: "Group1",
                                        adminID: "",
                                        positions: [],
                                        link: "", tasks: [])
    let groupID: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Image("\(groupInfo.avatar)")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text("Group's name")
                TextField("Digite o nome do grupo", text: $groupInfo.name)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.2))
                
                DescriptionGroup(groupInfo: $groupInfo)
                
                Text("Link")
                TextField("www.slanseiqla.com", text: $groupInfo.link)
                    .textFieldStyle(.roundedBorder)
                
                Text("Participants")
                
            }.padding(.horizontal)
                .toolbar {
                    Button {
                        viewModel.editGroup(groupInfo)
                    } label: {
                        Text("Salvar")
                            .foregroundColor(.black)
                    }

                }
                .onAppear {
                    guard let editGroup = viewModel.getGroup(id: groupID) else { return }
                    groupInfo = editGroup
                }
    
        }
    }
    
}

struct EditDetailsGroup_Previews: PreviewProvider {
    static var previews: some View {
        EditDetailsGroup(groupID: "12134")
            .environmentObject(GroupViewModel(service: GroupMockupService()))
    }
}
