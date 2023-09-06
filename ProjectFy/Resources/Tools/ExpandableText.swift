//
//  ExpandableText.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 04/09/23.
//

import SwiftUI

struct ExpandableText: View {
    
    @State private var expanded: Bool = false
    @Binding var updateAdvertisements: Bool
    
    var text: String
    let lineLimit: Int
    let user: User
    let advertisement: Advertisement
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text((expanded ? text : truncatedText()))
                .lineLimit(expanded ? nil : lineLimit)

            if !expanded && shouldShowReadMore() {
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
