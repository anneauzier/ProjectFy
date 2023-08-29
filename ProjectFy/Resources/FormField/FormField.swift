//
//  FormField.swift
//  ProjectFy
//
//  Created by Iago Ramos on 14/08/23.
//

import Foundation
import SwiftUI

struct FormField: View {
    @Environment(\.dynamicTypeSize) var sizeCategory
    
    let title: String
    let titleAccessibilityLabel: String
    
    let placeholder: String
    @Binding var text: String
    let textFieldAccessibilityLabel: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.backgroundRole)
                .accessibilityLabel(titleAccessibilityLabel)
            
            if sizeCategory.isAccessibilitySize {
                TextField(placeholder, text: $text)
                    .font(.body)
                    .accessibilityLabel(textFieldAccessibilityLabel)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.rectangleLine)
                            .padding(.top, 55)
                    )
            } else {
                TextField(placeholder, text: $text)
                // .limitInputLength(value: $text, length: 19, commaLimit: 30)
                    .font(.body)
                    .accessibilityLabel(textFieldAccessibilityLabel)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.rectangleLine)
                            .padding(.top, 30)
                    )
            }
        }
    }
}
