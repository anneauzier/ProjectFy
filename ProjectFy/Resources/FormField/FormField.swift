//
//  FormField.swift
//  ProjectFy
//
//  Created by Iago Ramos on 14/08/23.
//

import Foundation
import SwiftUI

struct FormField: View {
    let title: String
    let titleAccessibilityLabel: String
    
    let placeholder: String
    @Binding var text: String
    let textFieldAccessibilityLabel: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .accessibilityLabel(titleAccessibilityLabel)
            
            TextField(placeholder, text: $text)
                .textFieldStyle(.roundedBorder)
                .accessibilityLabel(textFieldAccessibilityLabel)
        }
    }
}
