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
                SetupUserInfo(user: $editingUser, canContinue: $canContinue, isNewUser: isNewUser)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        actionDiscard.toggle()
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
            }.confirmationDialog("", isPresented: $actionDiscard, actions: {
                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text("Discard Changes")
                }

            })
            .navigationTitle("Editar perfil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
