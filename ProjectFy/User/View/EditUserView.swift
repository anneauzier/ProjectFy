//
//  EditUserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

struct EditUserView: View {
    @EnvironmentObject var coordinator: Coordinator<UserRouter>
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var editingUser: User
    
    @State var actionDiscard = false
    @State var canContinue = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(editingUser.avatar)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding([.top, .bottom], 32)
                
                SetupUserInfo(user: $editingUser, canContinue: $canContinue)
            }
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    if didChangeInfo() {
                        coordinator.dismiss()
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
                    coordinator.dismiss()
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
                coordinator.dismiss()
            } label: {
                Text("Discard Changes")
            }
        })
        .navigationTitle("Edit Profile")
        .navigationBarTitleDisplayMode(.inline)
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
