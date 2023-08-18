//
//  EditUserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

struct EditUserView: View {

    @Environment(\.dismiss) var dismiss

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
                        dismiss()
                    } label: {
                        Text("Cancelar")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .bold()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.editUser(editingUser)
                        
                        Haptics.shared.notification(.success)
                        dismiss()
                    } label: {
                        Text("Salvar")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .bold()
                            .opacity(canContinue ? 1 : 0.2)
                    }
                    .disabled(!canContinue)
                }
            }
            .navigationTitle("Editar perfil")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
