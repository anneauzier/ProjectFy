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
    
    var body: some View {
        HStack {
            Image(user.avatar)
                .resizable()
                .frame(width: size, height: size)
            
            VStack(alignment: .leading) {
                HStack(spacing: 5) {
                    Text(user.name)
                    Text(user.username)
                        .opacity(0.5)
                }
                
                HStack(spacing: 9) {
                    Text(user.areaExpertise)
                    
                    Circle()
                        .frame(width: 4, height: 4)
                        .opacity(0.5)
                    
                    Text(user.expertise.rawValue)
                        .opacity(0.5)
                }
            }
        }
    }
}
