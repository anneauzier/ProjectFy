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
        @EnvironmentObject var viewModel: AdvertisementsViewModel
        
        @Binding var popToRoot: Bool
        var editingID: String?
        
        @State var advertisement = Advertisement(id: UUID().uuidString,
                                                 ownerID: "1234",
                                                 title: "",
                                                 description: "",
                                                 positions: [],
                                                 applicationsIDs: nil,
                                                 weeklyWorkload: nil,
                                                 ongoing: false,
                                                 tags: [])
        
        var body: some View {
            VStack(alignment: .leading) {
                TextField("Título do Projeto", text: $advertisement.title)
                    .font(.title)
                
                TextField("Descrição do anúncio...", text: $advertisement.description)
                    .padding(.top, 54)
                    
                Text("Status do projeto")
                    .padding(.top, 56)
                
                Picker("Status do projeto", selection: $advertisement.ongoing) {
                    Text("Em andamento")
                        .tag(true)
                    
                    Text("Não iniciado")
                        .tag(false)
                }
                .padding(.top, 6)
                
                Spacer()
            }
            .padding([.horizontal, .top], 16)
            
            .onAppear {
                guard let editingID = editingID else { return }
                guard let advertisement = viewModel.getAdvertisement(by: editingID) else { return }
                
                self.advertisement = advertisement
            }
            
            .toolbar {
                NavigationLink {
                    Positions(
                        advertisement: $advertisement,
                        popToRoot: $popToRoot,
                        isEditing: editingID != nil
                    )
                        .environmentObject(viewModel)
                } label: {
                    Text("Avançar")
                }
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
        
                        return
                    }
                    
                    viewModel.createAdvertisement(advertisement)
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
