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
    @EnvironmentObject var groupViewModel: GroupViewModel
    
    let user: User
    @State var advertisements: [Advertisement] = []
    @StateObject private var networking = NetworkManager()
    
    @State var isLinkActive = false
    @State var editingID: String?
    
    @State var presentSheet = false
    @State var presentMaxGroupsAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Divider()
                if !networking.isConnected {
                    Connectivity(image: Image("networking"),
                                 title: "Sorry, we couldn't load this page :(",
                                 description: "Check your connection to see if there's something wrong",
                                 heightPH: 0.7)
                } else if advertisementsViewModel.advertisements.isEmpty {
                    Connectivity(image: Image("emptyAd"),
                                 title: "Looks like people \nhaven't shared project \nideas yet :(",
                                 description: "You can start to share your project ideas by taping on “+”",
                                 heightPH: 0.7)
                } else {
                    VStack {
                        ForEach(advertisements, id: \.self) { advertisement in
                            AdView(
                                user: user,
                                owner: advertisement.owner,
                                advertisement: advertisement,
                                editingID: $editingID,
                                editAdvertisement: $isLinkActive
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .onAppear {
                editingID = nil
                updateAdvertisements()
            }
            
            .refreshable {
                updateAdvertisements()
            }
            
            .toolbar {
                Button {
                    if groupViewModel.groups.count >= 3 {
                        Haptics.shared.notification(.error)
                        presentMaxGroupsAlert = true
                        
                        return
                    }
                    
                    presentSheet.toggle()
                    Haptics.shared.selection()
                } label: {
                    Label("new advertisement", systemImage: "plus")
                        .font(Font.system(size: 20).bold())
                        .foregroundColor(.textColorBlue)
                }
            }
            
            .sheet(isPresented: $presentSheet) {
                NewAdvertisement(
                    owner: user,
                    viewModel: advertisementsViewModel,
                    dismiss: $presentSheet,
                    editingID: editingID
                )
            }
            
            .alert("You can't create a new advertisement beacause you are already in  three projects",
                   isPresented: $presentMaxGroupsAlert,
                   actions: {
                Button(role: .cancel) {
                    presentMaxGroupsAlert = false
                } label: {
                    Text("OK")
                }
            },
                   message: {
                Text("you cannot participate in more than three projects at the same time")
            }
            )
        }
    }
    
    private func updateAdvertisements() {
        advertisements = advertisementsViewModel.advertisements
    }
}

struct AdView: View {
    @EnvironmentObject var viewModel: AdvertisementsViewModel
    
    let user: User
    let owner: User
    let advertisement: Advertisement
    
    @Binding var editingID: String?
    @Binding var editAdvertisement: Bool
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NavigationLink {
                    UserView(presentUsersProfile: true, user: owner)
                } label: {
                    UserInfo(user: owner, size: 49, nameColor: .backgroundRole)
                }.padding(.top, 3)
                
                Spacer()
                
                if owner.id == user.id {
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
                            Label("Delete announce", systemImage: "trash")
                        }
                    } label: {
                        Label("Options", systemImage: "ellipsis")
                            .labelStyle(.iconOnly)
                            .font(Font.system(size: 20).bold())
                            .tint(.editAdvertisementText)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 23)
                }
            }
            
            AdInfo(user: user, advertisement: advertisement)
        }.navigationBarTitleDisplayMode(.inline)
        
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
