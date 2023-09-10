//
//  ExpandableText.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 04/09/23.
//

import SwiftUI

struct ExpandableText: View {
    
    var text: String
    let lineLimit: Int
    let user: User
    let advertisement: Advertisement
    
    var body: some View {
        
        VStack(alignment: .leading) {

            if !shouldShowReadMore() {
                Text(text)
                    .font(.body)
                    .lineLimit(!shouldShowReadMore() ? nil : lineLimit)
            } else {
                    Text(truncatedText() + "...") +
                    
                    Text(" See more")
                        .font(.headline)
                        .foregroundColor(.blue)
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
