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
    var viewModel: UserViewModel
    
    init(editingUser: User, viewModel: UserViewModel) {
        self._editingUser = State(initialValue: editingUser)
        self.viewModel = viewModel
    }

    var textFieldsFilled: Bool {
        !editingUser.name.isEmpty
        && !editingUser.areaExpertise.isEmpty
        && !editingUser.region.isEmpty
        && !editingUser.interestTags.isEmpty
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
//                HStack {
//                    Button {
//                        dismiss()
//                    } label: {
//                        Text("Cancelar")
//                            .font(.subheadline)
//                            .foregroundColor(.black)
//                            .bold()
//                    }
//                    Spacer()
//                    
//                    Text("Editar perfil")
//                        .foregroundColor(.black)
//                        .font(.headline)
//                    
//                    Spacer()
//                    
//                    Button {
//                        viewModel.editUser(editingUser)
//                        dismiss()
//                    } label: {
//                        Text("Salvar")
//                            .font(.subheadline)
//                            .foregroundColor(.black)
//                            .bold()
//                            .opacity(!textFieldsFilled ? 0.2: 1)
//                    }.disabled(!textFieldsFilled)
//                }.padding(.top, 20)
                
                Group {
                    Text("Nome")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .accessibilityLabel("Seu nome")

                    TextField("Digite aqui seu nome", text: $editingUser.name)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityLabel("Digite aqui seu nome")
                }
                
                Group {
                    Text("Username")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .accessibilityLabel("Your username")

                    TextField("@", text: $editingUser.username)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityLabel("Type here your username")
                }
                
                Group {
                    Text("Área de Conhecimento")
                        .font(.headline)
                        .foregroundColor(.gray)
                    TextField("Digite aqui sua área de interesse(Ex: UI/UX, etc)",
                              text: $editingUser.areaExpertise)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityLabel("Digite aqui sua área de interesse")
                }
                
                Group {
                    
                    
                    
                    
                    
                    
                    DropDownButton(
                        title: "Nível de conhecimento",
                        selection: $editingUser.expertise,
                        menuItems: User.Expertise.allCases.map({ expertise in
                            MenuItem(name: expertise.rawValue, tag: expertise)
                        })
                    )
                    
                    Text("Localização")
                        .font(.headline)
                        .foregroundColor(.gray)
                    TextField("State, Country", text: $editingUser.region)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityLabel("Digite seu estado, depois país")
                    
                    Text("Interesses")
                        .font(.headline)
                        .foregroundColor(.gray)
                    
//                     TODO: Mudar para o textfield vertical
                    TextField("Seus interesses", text: $editingUser.interestTags)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityLabel("Digite seus interesses")
                    
                    Toggle(isOn: $editingUser.available) {
                        Text("Disponibilidade")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    
                }.padding(.top, 10)
                
                Spacer()
                
            }.padding(.horizontal, 20)
        }
    }
}
