//
//  DropDownButton.swift
//  ProjectFy
//
//  Created by Iago Ramos on 08/08/23.
//

import Foundation
import SwiftUI

struct DropDownButton<T: Hashable>: View {
    @Environment(\.dynamicTypeSize) var sizeCategory
    let title: String
    let textColor: Color
    @Binding var selection: T
    let menuItems: [MenuItem<T>]
    
    @State var text: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.backgroundRole)
            
            Menu {
                ForEach(menuItems) { item in
                    Button {
                        text = item.name
                        selection = item.tag
                    } label: {
                        HStack {
                            Text(item.name)
                                .font(.body)
                            if item.tag == selection {
                                Spacer()
                                Image(systemName: "checkmark")
                                    .foregroundColor(.backgroundRole)
                            }
                        }
                    }
                }
            } label: {
                Text(text)
                    .foregroundColor(textColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Image(systemName: "chevron.down")
                    .foregroundColor(Color.backgroundRole)
            }
            .padding(.top, 5)
            
            .background(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.rectangleLine)
                        .padding(.top, sizeCategory.isAccessibilitySize ? 55 : 30)
                        .environment(\.dynamicTypeSize, sizeCategory)
            )
            
            .onAppear {
                if let item = menuItems.first(where: { $0.tag == selection }) {
                    text = item.name
                }
            }
        }
    }
}

struct MenuItem<T: Hashable>: Identifiable {
    let id = UUID()
    let name: String
    let tag: T
}
