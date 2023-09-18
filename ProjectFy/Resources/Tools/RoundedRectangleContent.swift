//
//  RoundedRectangleContent.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 14/09/23.
//

import SwiftUI

struct RoundedRectangleContent<Content: View>: View {
    let cornerRadius: CGFloat
    let fillColor: Color
    
    let content: () -> Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(fillColor)
            content()
        }
    }
}
