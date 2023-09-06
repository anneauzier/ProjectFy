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
    
    @State var presentSheet = false
    @State var editingID: String?
    
    @State var selectedPosition: ProjectGroup.Position?
    @State var presentPositionSheet = false
    
    @State var presentMaxGroupsAlert = false
    @State var didUpdateAdvertisements = false
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Divider()
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
                        ForEach($advertisements, id: \.self) { $advertisement in
                            AdView(
                                user: user,
                                owner: advertisement.owner,
                                advertisement: $advertisement,
                                updateAdvertisements: $didUpdateAdvertisements,
                                presentPosition: $presentPositionSheet,
                                selectedPosition: $selectedPosition,
                                presentSheet: $presentSheet,
                                editingID: $editingID
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }
            }
            
            .onAppear {
                updateAdvertisements()
            }
            
            .onChange(of: advertisementsViewModel.advertisements, perform: { _ in
                if didUpdateAdvertisements {
                    updateAdvertisements()
                }
            })
            
            .onChange(of: presentSheet, perform: { newValue in
                if !newValue {
                    editingID = nil
                }
            })
            
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
                    updateAdvertisements: $didUpdateAdvertisements,
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
            }, message: {
                Text("you cannot participate in more than three projects at the same time")
            })
        }
    }
    
    private func updateAdvertisements() {
        advertisements = advertisementsViewModel.advertisements.sorted(by: { $0.date > $1.date })
        didUpdateAdvertisements = false
    }
}

struct AdView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    
    let user: User
    let owner: User
    
    @Binding var advertisement: Advertisement
    @Binding var updateAdvertisements: Bool
    @Binding var presentPosition: Bool
    @Binding var selectedPosition: ProjectGroup.Position?
    @Binding var presentSheet: Bool
    @Binding var editingID: String?
    
    @State var showDeleteAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                NavigationLink {
                    UserView(presentUsersProfile: true, user: owner)
                } label: {
                    UserInfo(user: owner, size: 49, nameColor: .backgroundRole)
                }.padding(.top, 15)
                
                Spacer()
                
                if owner.id == user.id {
                    Menu {
                        Button {
                            editingID = advertisement.id
                            
                            Haptics.shared.selection()
                            presentSheet.toggle()
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

            AdInfo(
                user: user,
                advertisement: advertisement,
                updateAdvertisements: $updateAdvertisements
//                selectedPosition: $selectedPosition,
//                presentSheet: $presentPosition
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .alert("Do you really want to delete this project announcement?", isPresented: $showDeleteAlert) {
            Button(role: .cancel) {
                showDeleteAlert.toggle()
            } label: {
                Text("Cancel")
            }
            
            Button(role: .destructive) {
                advertisementsViewModel.deleteAdvertisement(with: advertisement.id)
                updateAdvertisements.toggle()
                
                Haptics.shared.notification(.success)
                showDeleteAlert.toggle()
            } label: {
                Text("Delete")
            }
        }
    }
}
