//
//  AdItemView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 14/09/23.
//

import SwiftUI

struct AdItemView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    
    let user: User
    let owner: User
    
    @State var showDeleteAlert: Bool = false
    @State private var showCustomAlert: Bool = false
    
    @Binding var advertisement: Advertisement
    @Binding var selectedPosition: ProjectGroup.Position?
    
    @Binding var updateAdvertisements: Bool
    @Binding var presentPosition: Bool
    @Binding var presentNewAdvertisementSheet: Bool
    
    @Binding var editingID: String?
    
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
                            presentNewAdvertisementSheet.toggle()
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
                        Image(systemName: "ellipsis")
                            .font(Font.system(size: 20).bold())
                            .tint(.editAdvertisementText)
                            .padding(.vertical, 20)
                            .padding(.horizontal, 3)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.top, 15)
                }
            }.padding(.horizontal, 20)
            
            AdInfo(user: user, advertisement: advertisement, updateAdvertisements: $updateAdvertisements)
            
        }.navigationBarTitleDisplayMode(.inline)
        
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
