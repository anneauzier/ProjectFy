//
//  DetailsAdvertisementView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 05/09/23.
//

import SwiftUI

struct DetailsAdvertisementView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    @State var advertisements: [Advertisement] = []
    @Binding var updateAdvertisements: Bool

    let text: String
    let user: User
    let advertisement: Advertisement
    
    @State var presentSheet = false
    @State var editingID: String?
    
    @State var selectedPosition: ProjectGroup.Position?
    @State var presentPositionSheet = false
    
    @State var presentMaxGroupsAlert = false
    @State var didUpdateAdvertisements = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                UserInfo(user: advertisement.owner, size: 49, nameColor: .backgroundRole)
                    .padding(.top, 6)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(advertisement.tags.split(separator: ","), id: \.self) { tag in
                            AdView.Tag(text: String(tag))
                        }
                    }
                }
                
                Text(advertisement.title)
                    .font(Font.largeTitle.bold())
                    .foregroundColor(.backgroundRole)
                    .padding(.top, 10)
                
                Text(advertisement.description)
                    .padding(.top, 8)
                
                Text("Project roles")
                    .font(Font.title.bold())
                    .foregroundColor(.backgroundRole)
                    .padding(.top, 15)
    
                VStack {
                    ForEach(advertisement.positions, id: \.self) { position in
                        Button {
                            selectedPosition = position
                            Haptics.shared.selection()
                        } label: {
                            AdView.Position(user: user, advertisement: advertisement, position: position)
                        }
                        
                        .onChange(of: selectedPosition, perform: { selectedPosition in
                            if selectedPosition != nil {
                                presentSheet = true
                            }
                        })
                        
                        .onChange(of: presentSheet) { presentSheet in
                            if !presentSheet {
                                selectedPosition = nil
                            }
                        }
                        
                        .sheet(isPresented: $presentSheet) {
                            if let position = selectedPosition {
                                AdView.PositionDetails(
                                    user: user,
                                    advertisement: advertisement,
                                    position: position,
                                    updateAdvertisements: $updateAdvertisements
                                )
                            } else {
                                Text("Position not found!")
                            }
                        }
                    }
                }.padding(.bottom, 10)
            }.frame(width: UIScreen.main.bounds.width - 40)
        }
    }
}
