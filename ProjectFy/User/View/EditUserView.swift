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
    
    let editingID: String
    
    var textFieldsFilled: Bool {
        !editingUser.name.isEmpty
        && !editingUser.areaExpertise.isEmpty
        && !editingUser.region.isEmpty
        && !editingUser.interestTags.isEmpty
    }
    
    @State var editingUser = User(id: "",
                                  name: "",
                                  username: "",
                                  email: "",
                                  description: nil,
                                  avatar: "Group1",
                                  region: "",
                                  entryDate: Date(),
                                  interestTags: "",
                                  expertise: .beginner,
                                  applicationsID: [],
                                  available: true,
                                  areaExpertise: "")
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
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
                        
                        DropDownButton(
                            title: "Area knowledge level",
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
            }.toolbar {
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
            .onAppear {
                if let user = viewModel.getUser(id: editingID) {
                    editingUser = user
                }
            }.navigationTitle("Editar perfil")
             .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = UserViewModel(service: UserMockupService())
        EditUserView(viewModel: viewModel, editingID: "")
    }
}
