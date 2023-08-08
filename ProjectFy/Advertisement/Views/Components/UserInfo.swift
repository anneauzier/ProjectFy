//
//  UserInfo.swift
//  ProjectFy
//
//  Created by Iago Ramos on 03/08/23.
//

import Foundation
import SwiftUI

extension AdView {
    struct UserInfo: View {
        let user: User
        
        var body: some View {
            HStack {
                Circle()
                    .frame(width: 67, height: 67)
                    .opacity(0.5)
                
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
}
