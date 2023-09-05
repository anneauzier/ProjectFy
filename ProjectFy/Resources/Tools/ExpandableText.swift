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
                NavigationLink(destination: DetailsAdvertisementView(
                                            updateAdvertisements: $updateAdvertisements,
                                            text: text, user: user,
                                            advertisement: advertisement)) {
                    Text("... See more")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
        }
    }
    
    private func truncatedText() -> String {
        return String(text.prefix(lineLimit * 40))
    }
    
    private func shouldShowReadMore() -> Bool {
        return text.count > lineLimit * 40
    }
}
