//
//  EditUserView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

struct EditUserView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: EditUserViewModel
    
    init(viewModel: EditUserViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    viewModel.cancelChanges()
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
                    viewModel.saveChanges()
                    dismiss()
                } label: {
                    Text("Salvar")
                        .font(.subheadline)
                        .foregroundColor(.black)
                        .bold()
                }
            }.padding(.top, 20)
            
            Circle()
                .frame(width: 100)
                .foregroundColor(.gray)
                .padding(.vertical, 20)
            
            Group {
                Text("Nome")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                TextField("Digite aqui seu nome", text: $viewModel.newUsername)
                    .textFieldStyle(.roundedBorder)
                
                Text("Área de Conhecimento")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                TextField("Digite aqui sua área de interesse(Ex: UI/UX, etc)",
                          text: $viewModel.editedAreaExpertise)
                .textFieldStyle(.roundedBorder)
                
                Text("Interesses")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                TextField("Seus interesses", text: $viewModel.editedInterests)
                    .textFieldStyle(.roundedBorder)
                
            }.padding(.bottom, 4)
            
            Spacer()
            
        }.padding(.horizontal, 20)
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EditUserViewModel()
        EditUserView(viewModel: viewModel)
    }
}
