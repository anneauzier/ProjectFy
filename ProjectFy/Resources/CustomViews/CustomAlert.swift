//
//  CustomAlert.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 31/08/23.
//

import SwiftUI

struct CustomAlert: View {
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.body)
                .foregroundColor(.white)
 
        }.frame(width: UIScreen.main.bounds.width - 80, alignment: .leading)
            .padding()
            .background(Color.black.opacity(0.8))
            .cornerRadius(12)
    }
}

extension AnyTransition {
    static var moveFromBottom: AnyTransition {
        AnyTransition.offset(y: UIScreen.main.bounds.height)
            .combined(with: .move(edge: .bottom))
    }
}
