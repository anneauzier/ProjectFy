//
//  AdvertisementListView.swift
//  ProjectFy
//
//  Created by Iago Ramos on 31/07/23.
//

import SwiftUI

struct AdvertisementListView: View {
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var groupViewModel: GroupViewModel
    @StateObject private var networking = NetworkManager()
    
    @State var advertisements: [Advertisement] = []
    @State var selectedPosition: ProjectGroup.Position?
    @State var editingID: String?
    
    @State var presentNewAdvertisementSheet = false
    @State var presentPositionSheet = false
    @State var presentMaxGroupsAlert = false
    @State var didUpdateAdvertisements = false
    
    let user: User
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                Divider()
                if !networking.isConnected {
                    CustomPlaceholder(image: Image("networking"),
                                      title: "Sorry, we couldn't load this page :(",
                                      description: "Check your connection to see if there's something wrong",
                                      height: 0.7)
                } else if advertisementsViewModel.advertisements.isEmpty {
                    CustomPlaceholder(image: Image("emptyAd"),
                                      title: "Looks like people \nhaven't shared project \nideas yet :(",
                                      description: "You can start to share your project ideas by taping on “+”",
                                      height: 0.7)
                } else {
                    VStack {
                        ForEach($advertisements, id: \.self) { $advertisement in
                            AdItemView(
                                user: user,
                                owner: advertisement.owner,
                                advertisement: $advertisement,
                                selectedPosition: $selectedPosition, updateAdvertisements: $didUpdateAdvertisements,
                                presentPosition: $presentPositionSheet,
                                presentNewAdvertisementSheet: $presentNewAdvertisementSheet,
                                editingID: $editingID
                            )
                        }
                    }.padding(.horizontal, 20)
                }
            }

            .onAppear {
                updateAdvertisementsByOrder()
            }
            
            .onChange(of: advertisementsViewModel.advertisements, perform: { _ in
                if advertisements.isEmpty || didUpdateAdvertisements {
                    updateAdvertisementsByOrder()
                }
            })
            
            .onChange(of: presentNewAdvertisementSheet, perform: { newValue in
                if !newValue {
                    editingID = nil
                }
            })

            .refreshable {
                updateAdvertisementsByOrder()
            }
            
            .toolbar {
                Button {
                    if groupViewModel.groups.count >= 3 {
                        Haptics.shared.notification(.error)
                        presentMaxGroupsAlert = true
                        return
                    }
                    presentNewAdvertisementSheet.toggle()
                    Haptics.shared.selection()
                    
                } label: {
                    Image(systemName: "plus")
                        .font(Font.system(size: 20).bold())
                        .foregroundColor(.textColorBlue)
                }
            }

            .sheet(isPresented: $presentNewAdvertisementSheet) {
                NewAdvertisement(
                    owner: user,
                    viewModel: advertisementsViewModel,
                    dismiss: $presentNewAdvertisementSheet,
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

    private func updateAdvertisementsByOrder() {
        advertisements = advertisementsViewModel.advertisements.sorted(by: { $0.date > $1.date })
        didUpdateAdvertisements = false
    }
}
