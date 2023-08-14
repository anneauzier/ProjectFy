//
//  NewAdvertisement.swift
//  ProjectFy
//
//  Created by Iago Ramos on 06/08/23.
//

import Foundation
import SwiftUI

extension AdvertisementsView {
    struct NewAdvertisement: View {
        @Environment(\.dismiss) var dismiss
        
        @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
        @EnvironmentObject var userViewModel: UserViewModel
        
        @State var advertisement: Advertisement
        @State var presentBackAlert: Bool = false
        
        var viewModel: AdvertisementsViewModel
        @Binding var popToRoot: Bool
        var editingID: String?
        
        init(ownerID: String, viewModel: AdvertisementsViewModel, popToRoot: Binding<Bool>, editingID: String?) {
            self._advertisement = State(initialValue: Advertisement(ownerID: ownerID))
            self.viewModel = viewModel
            self._popToRoot = popToRoot
            self.editingID = editingID
        }
        
        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
//                    UserInfo(user: userViewModel.user, size: 50)
                    
                    TextField("Adicione tags ao seu projeto...", text: $advertisement.tags)
                        .padding(.top, 25)
                    
                    TextField("Título do Projeto", text: $advertisement.title)
                        .font(.title)
                        .padding(.top, 44)
                    
                    TextField("Descrição do anúncio...", text: $advertisement.description)
                        .padding(.top, 54)
                    
                    DropDownButton(
                        title: "Status do projeto",
                        selection: $advertisement.ongoing,
                        menuItems: [
                            MenuItem(name: "Não iniciado", tag: false),
                            MenuItem(name: "Em andamento", tag: true)
                        ]
                    )
                    .padding(.top, 20)
                    
                    Spacer()
                }
                .padding([.horizontal, .top], 16)
            }
            
            .onAppear {
                guard let editingID = editingID else { return }
                guard let advertisement = viewModel.getAdvertisement(with: editingID) else { return }
                
                self.advertisement = advertisement
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentBackAlert = true
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                            Text("Back")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        Positions(
                            advertisement: $advertisement,
                            popToRoot: $popToRoot,
                            isEditing: editingID != nil
                        )
                            .environmentObject(advertisementsViewModel)
                    } label: {
                        Text("Avançar")
                    }

                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        Haptics.shared.selection()
                    }))
                }
            }
            
            .alert("Você deseja mesmo descartar a publicação?", isPresented: $presentBackAlert) {
                Button(role: .cancel) {
                    presentBackAlert = false
                } label: {
                    Text("Cancel")
                }

                Button(role: .destructive) {
                    dismiss()
                } label: {
                    Text("Ok")
                }
            } message: {
                Text("Você perderá todas as informações preenchidas")
            }

        }
    }
    
    private struct Positions: View {
        @EnvironmentObject var viewModel: AdvertisementsViewModel
        
        @Binding var advertisement: Advertisement
        @Binding var popToRoot: Bool
        
        let isEditing: Bool
        
        var body: some View {
            ScrollView {
                VStack {
                    Text("Criar vagas de projeto")
                        .font(.title)
                    
                    ForEach(0..<advertisement.positions.count, id: \.self) { index in
                        Position(position: $advertisement.positions[index])
                    }
                    
                    HStack {
                        Button {
                            newPosition()
                            Haptics.shared.selection()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(.blue)
                                
                                // TODO: trocar o bold por um que esteja disponível em outras versões do iOS
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
//                                    .fontWeight(.bold)
                            }
                            .frame(width: 54, height: 54)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .onAppear {
                if advertisement.positions.isEmpty {
                    newPosition()
                }
            }
            .toolbar {
                Button {
                    if isEditing {
                        viewModel.editAdvertisement(advertisement)
                        popToRoot.toggle()
        
                        Haptics.shared.notification(.success)
                        return
                    }
                    
                    viewModel.createAdvertisement(advertisement)
                    
                    Haptics.shared.notification(.success)
                    popToRoot.toggle()
                } label: {
                    Text(isEditing ? "Editar" : "Publicar")
                }
            }
        }
        
        private func newPosition() {
            advertisement.positions.append(
                ProjectGroup.Position(
                    id: UUID().uuidString,
                    title: "",
                    description: "",
                    vacancies: 1,
                    applied: [],
                    joined: []
                )
            )
        }
    }
    
    private struct Position: View {
        @Binding var position: ProjectGroup.Position
        
        var body: some View {
            RoundedRectangleContent(cornerRadius: 20, fillColor: .mint) {
                VStack(alignment: .leading) {
                    Text("Nome da vaga")
                    TextField("Nome da vaga", text: $position.title)
                    
                    Divider()
                    
                    Text("Descrição da vaga (opcional)")
                    TextField("Responsabilidades de quem irá assumir...", text: $position.description)
                    
                    Divider()
                    
                    HStack(spacing: 15) {
                        Text("Quantidade de vagas")
                        
                        Spacer()
                        
                        VacancyButton(position: $position, isPlusButton: false)
                        Text("\(position.vacancies)")
                        VacancyButton(position: $position, isPlusButton: true)
                    }
                }
                .padding(.all, 16)
            }
        }
    }
    
    private struct VacancyButton: View {
        @Binding var position: ProjectGroup.Position
        let isPlusButton: Bool
        
        var body: some View {
            Button {
                position.vacancies += isPlusButton ? 1 : -1
            } label: {
                ZStack {
                    Circle()
                        .fill(.blue)
                    
                    Image(systemName: isPlusButton ? "plus" : "minus")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
            }
            .disabled(!isPlusButton && position.vacancies < 2)
            .frame(width: 19, height: 19)
        }
    }
}
