//
//  StructurePlaceholder.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 22/08/23.
//

import SwiftUI

struct StructurePlaceholder: View {
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
                .opacity(0.8)
    
            Text(title)
                .font(Font.title2.bold())
                .foregroundColor(.placeholdertitle)
                .frame(width: UIScreen.main.bounds.width - 104)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .padding(.bottom, 5)
            
            Text(description)
                .font(.body)
                .foregroundColor(.editAdvertisementText)
                .frame(width: UIScreen.main.bounds.width - 114)
                .multilineTextAlignment(.center)
                .lineLimit(nil)
                .opacity(0.8)
        }
        .frame(height: UIScreen.main.bounds.height * heightPH)
    }
}

