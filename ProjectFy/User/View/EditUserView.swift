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
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancelar")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .bold()
                    }
                    Spacer()
                    
                    Text("Editar perfil")
                        .foregroundColor(.black)
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        viewModel.editUser(editingUser)
                        dismiss()
                    } label: {
                        Text("Salvar")
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .bold()
                            .opacity(!textFieldsFilled ? 0.2: 1)
                    }.disabled(!textFieldsFilled)
                }.padding(.top, 20)
                
                Group {
                    Text("Nome")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .accessibilityLabel("Seu nome")

                    TextField("Digite aqui seu nome", text: $editingUser.name)
                        .textFieldStyle(.roundedBorder)
                        .accessibilityLabel("Digite aqui seu nome")
                    
                    Text("Área de Conhecimento")
                        .font(.headline)
                        .foregroundColor(.gray)
                    TextField("Digite aqui sua área de interesse(Ex: UI/UX, etc)",
                              text: $editingUser.areaExpertise)
                    .textFieldStyle(.roundedBorder)
                    .accessibilityLabel("Digite aqui sua área de interesse")
                    
                    DropDownButton(viewModel: viewModel, editingUser: $editingUser)
                    
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

struct DropDownButton: View {
    @ObservedObject var viewModel: UserViewModel
    @Binding var editingUser: User

    let expertise = User.Expertise.allCases

    var body: some View {
        Text("Nivel de conhecimento")
            .font(.headline)
            .foregroundColor(.gray)

        Menu {
            ForEach(expertise, id: \.self) { type in
                MenuItem(type: type.rawValue, isSelected: type == editingUser.expertise) {
                    self.editingUser.expertise = type
                }
            }
        } label: {
            Text(editingUser.expertise.rawValue)
                .foregroundColor(Color.black)
                .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "arrowtriangle.down.fill")
                .foregroundColor(Color.black)
        }
        .padding(.horizontal, 10)
        .frame(minWidth: 0, maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .padding()
                .foregroundColor(.clear)
                .border(Color.secondary.opacity(0.18))
        }
        .accessibilityLabel("Escolha seu nível de conhecimento")
    }
}

struct MenuItem: View {
    let type: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            HStack {
                Text(type)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                        .foregroundColor(.black)
                }
            }
        })
    }
}
