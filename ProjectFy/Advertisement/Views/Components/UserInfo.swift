//
//  UserInfo.swift
//  ProjectFy
//
//  Created by Iago Ramos on 03/08/23.
//

import Foundation
import SwiftUI

struct UserInfo: View {
    let user: User
    let size: CGFloat
    let nameColor: Color
    
    var body: some View {
        
        HStack {
            Image(user.avatar)
                .resizable()
                .frame(width: size, height: size)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 5) {
                    Text(user.name)
                        .font(Font.headline)
                        .foregroundColor(nameColor)
                    Text(user.username)
                        .font(Font.subheadline)
                        .foregroundColor(.userNameColor)
                }.scaledToFit()
                
                HStack(spacing: 5) {
                    Text(user.areaExpertise)
                        .font(.body)
                        .foregroundColor(nameColor)
                    
                    Circle()
                        .frame(width: 3, height: 3)
                        .foregroundColor(.editAdvertisementText)
                    
                    Text(user.expertise.rawValue)
                        .font(.subheadline)
                        .foregroundColor(.editAdvertisementText)
                }.scaledToFit()
            }
        }.padding(.top, 10)
    }
}
