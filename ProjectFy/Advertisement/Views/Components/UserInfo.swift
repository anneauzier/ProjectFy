//
//  UserInfo.swift
//  ProjectFy
//
//  Created by Iago Ramos on 03/08/23.
//

import Foundation
import SwiftUI

struct UserInfo: View {
    @Environment(\.dynamicTypeSize) var sizeCategory

    let user: User
    let size: CGFloat
    let nameColor: Color
    
    var body: some View {
        
        HStack {
            Image(user.avatar)
                .resizable()
                .frame(width: size, height: size)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(user.name)
                        .font(Font.headline)
                        .foregroundColor(nameColor)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
//                    Text(user.username)
//                        .font(Font.subheadline)
//                        .foregroundColor(.userNameColor)
                }.scaledToFit()
                
                HStack(spacing: 5) {
                    Text(user.areaExpertise)
                        .font(.body)
                        .foregroundColor(nameColor)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)

                    Circle()
                        .frame(width: 3, height: 3)
                        .foregroundColor(.editAdvertisementText)
                    
                    Text(user.expertise.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.editAdvertisementText)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }.scaledToFit()
            }
        }
        .padding(.top, 10)
    }
}
