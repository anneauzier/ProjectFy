//
//  AdvertisementView.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import SwiftUI

struct AdvertisementView: View {
    @EnvironmentObject var viewModel: AdvertisementsViewModel
    
    @State var isLinkActive = false
    @State var editingID: String? = nil
    
    var body: some View {
        ScrollView {
            VStack {
                Divider()
                
                ForEach(viewModel.advertisements, id: \.self) { advertisement in
                    let viewModel = AdViewModel(
                        service: AdvertisementMockupService(),
                        advertisementID: advertisement.id
                    )
                    
                    if let owner = viewModel.owner, let advertisement = viewModel.advertisement {
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
                NewAdvertisement(popToRoot: $isLinkActive, editingID: editingID)
                    .environmentObject(viewModel)
            } label: {
                Label("Criar anúncio", systemImage: "plus")
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
                viewModel.deleteAdvertisement(by: advertisement.id)
                showDeleteAlert.toggle()
            } label: {
                Text("Excluir")
            }
        }
    }
}
