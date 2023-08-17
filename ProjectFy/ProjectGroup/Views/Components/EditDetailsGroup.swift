//
//  EditDetailsGroup.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 10/08/23.
//

import SwiftUI

struct EditDetailsGroup: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: GroupViewModel
    @State var groupInfo = ProjectGroup(id: "",
                                        name: "",
                                        description: "",
                                        avatar: "Group1",
                                        adminID: "",
                                        members: [:],
                                        link: "", tasks: [])
    let groupID: String
    
    var body: some View {
        NavigationView {
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
                    TextField("\(groupInfo.link)", text: $groupInfo.link)
                        .textFieldStyle(.roundedBorder)
                    
                    Text("Participants")
                    
                }.padding(.horizontal)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                dismiss()
                            } label: {
                                Text("X")
                                    .font(.headline)
                                    .foregroundColor(.black)
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button {
                                viewModel.editGroup(groupInfo)
                                dismiss()
                            } label: {
                                Text("Salvar")
                                    .foregroundColor(.black)
                            }
                        }
                    }
                    .onAppear {
                        guard let editGroup = viewModel.getGroup(id: groupID) else { return }
                        groupInfo = editGroup
                    }
            }
            .navigationTitle("Edit Group Info")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EditDetailsGroup_Previews: PreviewProvider {
    static var previews: some View {
        EditDetailsGroup(groupID: "12134")
            .environmentObject(GroupViewModel(service: GroupMockupService()))
    }
}
