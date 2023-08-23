//
//  TextFieldLimitModifer.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 20/08/23.
//

import SwiftUI
import Combine

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int
    var commaLimit: Int
    
    func body(content: Content) -> some View {
        content
            .onChange(of: $value.wrappedValue) { newValue in
                let commaCount = newValue.filter({ $0 == "," }).count
                if commaCount <= commaLimit {
                    value = String(newValue.prefix(length))
                } else {
                    value = String(newValue.prefix(value.count - 1))
                }
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int, commaLimit: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length, commaLimit: commaLimit))
    }
}
