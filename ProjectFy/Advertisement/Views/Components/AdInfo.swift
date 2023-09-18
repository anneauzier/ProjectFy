//
//  AdInfo.swift
//  ProjectFy
//
//  Created by Iago Ramos on 03/08/23.
//

import Foundation
import SwiftUI

extension AdItemView {

    struct AdInfo: View {
        @EnvironmentObject var userViewModel: UserViewModel
        
        let user: User
        let advertisement: Advertisement
        
        @Binding var updateAdvertisements: Bool
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(advertisement.tags.split(separator: ","), id: \.self) { tag in
                            Tag(text: String(tag))
                        }
                    }
                    .padding(.horizontal, 20)
                }
                NavigationLink {
                    DetailsAdView(updateAdvertisements: $updateAdvertisements,
                                             text: advertisement.description, user: user,
                                             advertisement: advertisement)
                } label: {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(advertisement.title)
                            .font(Font.largeTitle.bold())
                            .foregroundColor(.backgroundRole)
                        
                        ExpandableText(text: advertisement.description,
                                       lineLimit: 4, user: user, advertisement: advertisement)
                        
                    }.multilineTextAlignment(.leading)
                     .padding(.horizontal, 20)
                }.foregroundColor(.backgroundRole)
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 6)
                    .foregroundColor(.rectangleLine)
                    .padding(.top, 20)
    
            }.frame(width: UIScreen.main.bounds.width)
        }
    }
    
    struct Tag: View {
        
        let text: String
        
        var body: some View {
            RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundTextBlue) {
                Text(text)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .font(.callout)
                    .foregroundColor(.textColorBlue)
                    .lineLimit(0)
            }.padding(.top, 15)
        }
    }
}
