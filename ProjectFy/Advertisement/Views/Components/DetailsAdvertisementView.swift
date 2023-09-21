//
//  DetailsAdvertisementView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 05/09/23.
//

import SwiftUI

struct DetailsAdvertisementView: View {
    @EnvironmentObject var advertisertisementsCoordinator: Coordinator<AdvertisementsRouter>
    @EnvironmentObject var userCoordinator: Coordinator<UserRouter>
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel

    let user: User
    let advertisement: Advertisement
    var isUserAdvertisement = false
    
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
                            if isUserAdvertisement {
                                userCoordinator.show(.roleDetails(user, advertisement, position))
                                Haptics.shared.selection()
                                
                                return
                            }
                            
                            advertisertisementsCoordinator.show(.roleDetails(user, advertisement, position))
                            Haptics.shared.selection()
                        } label: {
                            AdView.Position(user: user, advertisement: advertisement, position: position)
                        }
                    }
                }.padding(.bottom, 40)
            }.frame(width: UIScreen.main.bounds.width - 40)
        }
    }
}
