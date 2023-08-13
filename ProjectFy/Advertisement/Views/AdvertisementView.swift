//
//  AdvertisementView.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import SwiftUI

struct AdvertisementsView: View {
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    let user: User
    
    @State var isLinkActive = false
    @State var editingID: String?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                    
                    ForEach(advertisementsViewModel.advertisements, id: \.self) { advertisement in
                        let owner = userViewModel.getUser(with: advertisement.ownerID)
                        
                        if let owner = owner {
                            AdView(
                                owner: owner,
                                advertisement: advertisement,
                                editingID: $editingID,
                                editAdvertisement: $isLinkActive
                            )
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            
            .onAppear {
                editingID = nil
            }
            
            .toolbar {
                NavigationLink(isActive: $isLinkActive) {
                    NewAdvertisement(ownerID: user.id,
                                     viewModel: advertisementsViewModel,
                                     popToRoot: $isLinkActive,
                                     editingID: editingID)
                } label: {
                    Label("Criar anúncio", systemImage: "plus")
                }
            }
        }
    }
}

struct AdView: View {
    @EnvironmentObject var viewModel: AdvertisementsViewModel
    
    let owner: User
    let advertisement: Advertisement
    
    @Binding var editingID: String?
    @Binding var editAdvertisement: Bool
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                UserInfo(user: owner)
                
                Spacer()
                
                Menu {
                    Button {
                        editingID = advertisement.id
                        editAdvertisement.toggle()
                    } label: {
                        Label("Editar anúncio", systemImage: "square.and.pencil")
                    }
                    
                    Button(role: .destructive) {
                        showDeleteAlert.toggle()
                    } label: {
                        Label("Excluir anúncio", systemImage: "trash")
                    }
                } label: {
                    Label("opções", systemImage: "ellipsis")
                        .labelStyle(.iconOnly)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 10)
                .padding(.leading, 27)
            }
            
            AdInfo(advertisement: advertisement)
            
            Divider()
        }
        
        .alert("Você deseja mesmo excluir a publicação?", isPresented: $showDeleteAlert) {
            Button(role: .cancel) {
                showDeleteAlert.toggle()
            } label: {
                Text("Cancelar")
            }

            Button(role: .destructive) {
                viewModel.deleteAdvertisement(with: advertisement.id)
                showDeleteAlert.toggle()
            } label: {
                Text("Excluir")
            }
        }
    }
}
