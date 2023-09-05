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
    @State var actionDiscardGroup = false
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
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding([.top, .bottom], 32)
                    
                    Text("Group name")
                        .font(.headline)
                        .foregroundColor(.backgroundRole)
                    
                    TextField("Enter the group name", text: $groupInfo.name)
                        .limitInputLength(value: $groupInfo.name, length: 19, commaLimit: 7)
                        .background(
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.rectangleLine)
                                .padding(.top, 30)
                        )
                        .padding(.bottom, 40)
                    
                    DescriptionGroup(groupInfo: $groupInfo)
                        .padding(.bottom, 40)
                    
                    Text("Link for chat and meetings")
                        .font(.headline)
                        .foregroundColor(.backgroundRole)
                    
                    CustomTextField(message: $groupInfo.link, placeholder: "https://web.whatsapp.com")
                        
                }.padding(.horizontal)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button {
                                if didChangeInfo() {
                                    dismiss()
                                    actionDiscardGroup = false
                                } else {
                                    actionDiscardGroup = true
                                }
                            } label: {
                                Image(systemName: "xmark")
                                    .font(Font.system(size: 15, weight: .bold))
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button {
                                viewModel.editGroup(groupInfo)
                                dismiss()
                            } label: {
                                Text("Save")
                                    .font(.body)
                                    .foregroundColor(.textColorBlue)
                            }
                            .opacity((groupInfo.name.isEmpty ||
                                      groupInfo.link.isEmpty ||
                                      groupInfo.description.isEmpty) ? 0.2 : 1.0)
                            
                            .disabled(canSave())
                        }
                    }.confirmationDialog("", isPresented: $actionDiscardGroup, actions: {
                        Button(role: .destructive) {
                            dismiss()
                        } label: {
                            Text("Discard Changes")
                        }
                    })
                    .navigationTitle("Edit Group Info")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    private func canSave() -> Bool {
        return groupInfo.name.isEmpty
        || groupInfo.link.isEmpty
        || groupInfo.description.isEmpty
    }
    
    private func didChangeInfo() -> Bool {
        let groups = viewModel.groups.contains { group in
            return groupInfo.name == group.name
            && groupInfo.description == group.description
            && groupInfo.link == group.link
        }
        return groups
    }
}
