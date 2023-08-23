//
//  EditUserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

struct EditUserView: View {

    @Environment(\.dismiss) var dismiss

    @State var actionDiscard = false
    @State var canContinue = false
    @State var editingUser: User
    
    var isNewUser: Bool
    var viewModel: UserViewModel
    
    init(editingUser: User, isNewUser: Bool = false, viewModel: UserViewModel) {
        self._editingUser = State(initialValue: editingUser)
        self.isNewUser = isNewUser
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    Image(editingUser.avatar)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding([.top, .bottom], 32)

                    SetupUserInfo(user: $editingUser, canContinue: $canContinue, isNewUser: isNewUser)
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        if didChangeInfo() {
                            dismiss()
                            actionDiscard = false
                        } else {
                            actionDiscard = true
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(Font.system(size: 15, weight: .bold))
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.editUser(editingUser)
                        
                        Haptics.shared.notification(.success)
                        dismiss()
                    } label: {
                        Text("Save")
                            .font(.body)
                            .foregroundColor(.textColorBlue)
                            .opacity(canContinue ? 1 : 0.2)
                    }
                    .disabled(!canContinue)
                }
            }
            .confirmationDialog("", isPresented: $actionDiscard, actions: {
                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text("Discard Changes")
                }
            })
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    private func didChangeInfo() -> Bool {
        guard let user = viewModel.user else { return false }

        return editingUser.name == user.name
        && editingUser.areaExpertise == user.areaExpertise
        && editingUser.interestTags == user.interestTags
        && editingUser.region == user.region
        && editingUser.available == user.available
    }
}
