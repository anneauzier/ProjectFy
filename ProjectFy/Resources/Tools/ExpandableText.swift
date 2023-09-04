//
//  ExpandableText.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 04/09/23.
//

import SwiftUI

struct ExpandableText: View {
    
    @State private var expanded: Bool = false
    
    var text: String
    let lineLimit: Int
    let user: User
    let advertisement: Advertisement
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text((expanded ? text : truncatedText()))
                .lineLimit(expanded ? nil : lineLimit)

            if !expanded && shouldShowReadMore() {
                NavigationLink(destination: DetailsAdvertisementView(text: text,
                                                                     user: user,
                                                                     advertisement: advertisement)) {
                    Text("... See more")
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    private func truncatedText() -> String {
        return String(text.prefix(lineLimit * 30))
    }
    
    private func shouldShowReadMore() -> Bool {
        return text.count > lineLimit * 30
    }
}

struct DetailsAdvertisementView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
    
    let text: String
    let user: User
    let advertisement: Advertisement
    
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
            }.frame(width: UIScreen.main.bounds.width - 40)
        }
    }
}
