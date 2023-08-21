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
    
    @State var selectedPositionToPresent: ProjectGroup.Position?
    @State var presentPositionSheet: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Divider()
                    
                    ForEach(advertisementsViewModel.advertisements, id: \.self) { advertisement in
                        AdView(
                            user: user,
                            owner: advertisement.owner,
                            advertisement: advertisement,
                            editingID: $editingID,
                            editAdvertisement: $isLinkActive,
                            selectedPositionToPresent: $selectedPositionToPresent,
                            presentPositionSheet: $presentPositionSheet
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            
            .onAppear {
                editingID = nil
            }
            
            .toolbar {
                NavigationLink(isActive: $isLinkActive) {
                    NewAdvertisement(owner: user,
                                     viewModel: advertisementsViewModel,
                                     popToRoot: $isLinkActive,
                                     editingID: editingID)
                } label: {
                    Label("Create ad", systemImage: "plus")
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
    
    let user: User
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
                    UserView(presentUsersProfile: true, user: owner)
                } label: {
                    UserInfo(user: owner, size: 49, nameColor: .black)
                }

                Spacer()
                
                Menu {
                    Button {
                        editingID = advertisement.id
                        
                        Haptics.shared.selection()
                        editAdvertisement.toggle()
                    } label: {
                        Label("Edit", systemImage: "square.and.pencil")
                    }
                    
                    Button(role: .destructive) {
                        Haptics.shared.impact(.rigid)
                        showDeleteAlert.toggle()
                    } label: {
                        Label("Delete Ad", systemImage: "trash")
                    }
                } label: {
                    Label("Options", systemImage: "ellipsis")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, 10)
                .padding(.leading, 27)
            }
            
            AdInfo(
                user: user,
                advertisement: advertisement,
                presentSheet: $presentPositionSheet,
                selectedPosition: $selectedPositionToPresent
            )
        }
        
        .alert("Do you really want to delete this project announcement?", isPresented: $showDeleteAlert) {
            Button(role: .cancel) {
                showDeleteAlert.toggle()
            } label: {
                Text("Cancel")
            }

            Button(role: .destructive) {
                viewModel.deleteAdvertisement(with: advertisement.id)
                Haptics.shared.notification(.success)
                
                showDeleteAlert.toggle()
            } label: {
                Text("Delete")
            }
        }
    }
}
