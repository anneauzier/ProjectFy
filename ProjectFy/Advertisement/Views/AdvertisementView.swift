//
//  AdvertisementView.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import SwiftUI

struct AdvertisementsView: View {
    @EnvironmentObject var coordinator: Coordinator<AdvertisementsRouter>
    
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    @EnvironmentObject var groupViewModel: GroupViewModel
    
    @StateObject private var networking = NetworkManager()
    
    let user: User
    @State var presentMaxGroupsAlert = false
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(showsIndicators: false) {
                Divider()
                    .id(0)
                
                if !networking.isConnected {
                    StructurePlaceholder(image: Image("networking"),
                                         title: "Sorry, we couldn't load this page :(",
                                         description: "Check your connection to see if there's something wrong",
                                         heightPH: 0.7)
                } else if advertisementsViewModel.advertisements.isEmpty {
                    StructurePlaceholder(image: Image("emptyAd"),
                                         title: "Looks like people \nhaven't shared project \nideas yet :(",
                                         description: "You can start to share your project ideas by taping on “+”",
                                         heightPH: 0.7)
                } else {
                    VStack {
                        ForEach(advertisementsViewModel.advertisements, id: \.self) { advertisement in
                            AdView(user: user, advertisement: advertisement)
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            .onChange(of: advertisementsViewModel.shouldScroll) { shouldScroll in
                if shouldScroll {
                    advertisementsViewModel.shouldScroll = false
                    
                    withAnimation {
                        proxy.scrollTo(0)
                    }
                }
            }
        }
        
        .onAppear {
            advertisementsViewModel.refreshAdvertisements()
        }
        
        .refreshable {
            advertisementsViewModel.refreshAdvertisements()
        }
        
        .toolbar {
            Button {
                if groupViewModel.groups.count >= 3 {
                    Haptics.shared.notification(.error)
                    presentMaxGroupsAlert = true
                    
                    return
                }
                
                coordinator.show(.newAdvertisement(user, Advertisement(owner: user)))
                Haptics.shared.selection()
            } label: {
                Label("new advertisement", systemImage: "plus")
                    .font(Font.system(size: 20).bold())
                    .foregroundColor(.textColorBlue)
            }
        }
        
        .alert("You can't create a new advertisement beacause you are already in  three projects",
               isPresented: $presentMaxGroupsAlert,
               actions: {
            Button(role: .cancel) {
                presentMaxGroupsAlert = false
            } label: {
                Text("OK")
            }
        }, message: {
            Text("you cannot participate in more than three projects at the same time")
        })
    }
}

struct AdView: View {
    @EnvironmentObject var coordinator: Coordinator<AdvertisementsRouter>
    @EnvironmentObject var viewModel: AdvertisementsViewModel
    
    let user: User
    let advertisement: Advertisement
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    coordinator.show(.profile(advertisement.owner))
                } label: {
                    UserInfo(user: advertisement.owner, size: 49, nameColor: .backgroundRole)
                }
                .padding(.top, 15)
                
                Spacer()
                
                if advertisement.owner.id == user.id {
                    Menu {
                        Button {
                            Haptics.shared.selection()
                            coordinator.show(.editAdvertisement(advertisement.owner, advertisement))
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
                            .padding(.vertical, 20)
                            .padding(.horizontal, 3)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 15)
                }
            }.padding(.horizontal, 20)
            
            AdInfo(user: user, advertisement: advertisement)
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .alert("Do you really want to delete this project announcement?", isPresented: $showDeleteAlert) {
            Button(role: .cancel) {
                showDeleteAlert.toggle()
            } label: {
                Text("Cancel")
            }
            
            Button(role: .destructive) {
                viewModel.deleteAdvertisement(with: advertisement.id)
                viewModel.refreshAdvertisements()
                
                Haptics.shared.notification(.success)
                showDeleteAlert.toggle()
            } label: {
                Text("Delete")
            }
        }
    }
}
