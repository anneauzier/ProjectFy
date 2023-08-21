//
//  EditDetailsGroup.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 10/08/23.
//

import SwiftUI

struct EditDetailsGroup: View {
    @Environment(\.dismiss) var dismiss
    
    @State var groupInfo: ProjectGroup
    var viewModel: GroupViewModel
    
    init(group: ProjectGroup, viewModel: GroupViewModel) {
        self._groupInfo = State(initialValue: group)
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    Image("\(groupInfo.avatar)")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Text("Group name")
                        .font(.headline)
                        .foregroundColor(.black)
                    TextField("Enter the group name", text: $groupInfo.name)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.2))
                    
                    DescriptionGroup(groupInfo: $groupInfo)
                    
                    Text("Link for chat or/and meetings")
                        .font(.headline)
                        .foregroundColor(.black)
                        
                    TextField("\(groupInfo.link)", text: $groupInfo.link)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled(true)

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
                            .opacity((groupInfo.name.isEmpty ||
                                      groupInfo.link.isEmpty ||
                                      groupInfo.description.isEmpty) ? 0.2 : 1.0)

                            .disabled(groupInfo.name.isEmpty ||
                                       groupInfo.link.isEmpty ||
                                       groupInfo.description.isEmpty)
                        }
                    }
                    .navigationTitle("Edit Group Info")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

// struct EditDetailsGroup_Previews: PreviewProvider {
//    static var previews: some View {
//        EditDetailsGroup(groupInfo: ProjectGroup(), viewModel: GroupViewModel(service: GroupMockupService()))
//    }
// }
