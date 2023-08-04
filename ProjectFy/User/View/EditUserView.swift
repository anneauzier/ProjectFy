//
//  EditUserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

struct EditUserView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var viewModel: UserViewModel
    @State var editingUser: User = User.mock[0]

    init(viewModel: UserViewModel) {
        self.viewModel = viewModel
        self.editingUser = viewModel.user
    }
    
    var body: some View {
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
                    viewModel.saveChanges(editedUser: editingUser)
                    dismiss()
                } label: {
                    Text("Salvar")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .bold()
                }
            }.padding(.top, 20)
 
            Group {
                Text("Nome")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Digite aqui seu nome", text: $editingUser.name)
                    .textFieldStyle(.roundedBorder)
                
                Text("Área de Conhecimento")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Digite aqui sua área de interesse(Ex: UI/UX, etc)",
                          text: $editingUser.areaExpertise)
                .textFieldStyle(.roundedBorder)
                
                DropDownButton(viewModel: viewModel, editingUser: $editingUser)
                
                Text("Localização")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("State, Country", text: $editingUser.region)
                    .textFieldStyle(.roundedBorder)
                
                Text("Interesses")
                    .font(.headline)
                    .foregroundColor(.gray)
                TextField("Seus interesses", text: $editingUser.interestTags)
                    .textFieldStyle(.roundedBorder)
                
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

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UserViewModel(user: User.mock[0])
        EditUserView(viewModel: viewModel)
    }
}

struct DropDownButton: View {

    @ObservedObject var viewModel: UserViewModel
    @State var selectedExpertise = ""
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
                .border(Color.gray.opacity(0.2))
        }
            
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
