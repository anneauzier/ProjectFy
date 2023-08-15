//
//  EditUserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

// TODO: tirar o dropdownbutton daqui

struct EditUserView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var editingUser: User
    var isNewUser: Bool
    var viewModel: UserViewModel
    
    init(editingUser: User, isNewUser: Bool = false, viewModel: UserViewModel) {
        self._editingUser = State(initialValue: editingUser)
        self.isNewUser = isNewUser
        self.viewModel = viewModel
    }
    
    var textFieldsFilled: Bool {
        !editingUser.name.isEmpty
        && !editingUser.areaExpertise.isEmpty
        && !editingUser.region.isEmpty
        && !editingUser.interestTags.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            FormField(
                title: "Nome",
                titleAccessibilityLabel: "Seu nome",
                placeholder: "Digite aqui seu nome",
                text: $editingUser.name,
                textFieldAccessibilityLabel: "Digite aqui seu nome"
            )
            
            if isNewUser {
                FormField(
                    title: "Username",
                    titleAccessibilityLabel: "Your username",
                    placeholder: "@",
                    text: $editingUser.username,
                    textFieldAccessibilityLabel: "Type here your username"
                )
            }
            
            FormField(
                title: "Área de conhecimento",
                titleAccessibilityLabel: "Digite aqui sua área de interesse (Ex: UI/UX)",
                placeholder: "Digite aqui sua área de interesse (Ex: UI/UX)",
                text: $editingUser.areaExpertise,
                textFieldAccessibilityLabel: "Digite aqui sua área de interesse"
            )
            
            DropDownButton(
                title: "Nível de conhecimento",
                selection: $editingUser.expertise,
                menuItems: User.Expertise.allCases.map({ expertise in
                    MenuItem(name: expertise.rawValue, tag: expertise)
                })
            )
            
            FormField(
                title: "Localização",
                titleAccessibilityLabel: "Sua localização",
                placeholder: "State, Country",
                text: $editingUser.region,
                textFieldAccessibilityLabel: "Digite seu estado e país"
            )
            
            FormField(
                title: "Interesses",
                titleAccessibilityLabel: "Seus interesses",
                placeholder: "Seus interesses",
                text: $editingUser.interestTags,
                textFieldAccessibilityLabel: "Digite seus interesses"
            )
            
            if !isNewUser {
                Toggle(isOn: $editingUser.available) {
                    Text("Disponibilidade")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
            
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
                        .opacity(!textFieldsFilled ? 0.2: 1)
                }.disabled(!textFieldsFilled)
            }
        }
        .navigationTitle("Editar perfil")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FormField: View {
    let title: String
    let titleAccessibilityLabel: String
    
    let placeholder: String
    @Binding var text: String
    let textFieldAccessibilityLabel: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.gray)
                .accessibilityLabel(titleAccessibilityLabel)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(.roundedBorder)
                .accessibilityLabel(textFieldAccessibilityLabel)
        }
    }
}
