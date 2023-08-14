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
    
    @State var isLinkActive = false
    @State var editingID: String?
    
    @State var selectedPositionToPresent: ProjectGroup.Position?
    @State var presentPositionSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                    
                    ForEach(advertisementsViewModel.advertisements, id: \.self) { advertisement in
                        let owner = userViewModel.getUser(id: advertisement.ownerID)
                        
                        if let owner = owner {
                            AdView(
                                owner: owner,
                                advertisement: advertisement,
                                editingID: $editingID,
                                editAdvertisement: $isLinkActive,
                                selectedPositionToPresent: $selectedPositionToPresent,
                                presentPositionSheet: $presentPositionSheet
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
                        .environmentObject(advertisementsViewModel)
                } label: {
                    Label("Criar anúncio", systemImage: "plus")
                }
                
                .simultaneousGesture(TapGesture().onEnded({ _ in
                    Haptics.shared.selection()
                }))
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
    
    @Binding var selectedPositionToPresent: ProjectGroup.Position?
    @Binding var presentPositionSheet: Bool
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {

                NavigationLink {
                    UserView(presentUsersProfile: true)

                } label: {
                    UserInfo(user: owner, size: 67)
                        .foregroundColor(.black)
                }

                Spacer()
                
                Menu {
                    Button {
                        editingID = advertisement.id
                        
                        Haptics.shared.selection()
                        editAdvertisement.toggle()
                    } label: {
                        Label("Editar anúncio", systemImage: "square.and.pencil")
                    }
                    
                    Button(role: .destructive) {
                        Haptics.shared.impact(.rigid)
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
            
            AdInfo(
                advertisement: advertisement,
                presentSheet: $presentPositionSheet,
                selectedPosition: $selectedPositionToPresent
            )
            
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
                
                Haptics.shared.notification(.success)
                showDeleteAlert.toggle()
            } label: {
                Text("Excluir")
            }
        }
    }
}
