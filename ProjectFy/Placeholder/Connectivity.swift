//
//  Connectivity.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 22/08/23.
//

import SwiftUI

struct Connectivity: View {
    let image: Image
    let title: String
    let description: String
    let heightPH: Double
    
    var body: some View {
        VStack(alignment: .center) {
            image
                .resizable()
                .frame(width: 155, height: 155)
                .padding(.bottom, 5)
    
            Text(title)
                .font(Font.title2.bold())
                .foregroundColor(.backgroundRole)
                .frame(width: UIScreen.main.bounds.width - 104)
                .multilineTextAlignment(.center)
                .padding(.bottom, 5)
            
            Text(description)
                .font(.body)
                .foregroundColor(.editAdvertisementText)
                .frame(width: UIScreen.main.bounds.width - 114)
                .multilineTextAlignment(.center)
        }.frame(height: UIScreen.main.bounds.height * heightPH)
    }
}
