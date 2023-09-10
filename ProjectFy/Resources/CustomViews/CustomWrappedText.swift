//
//  CustomWrappedText.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 31/08/23.
//

import SwiftUI

struct CustomWrappedText: View {
    @Binding var text: String
    @State var height: CGFloat?
    @FocusState var isTextFieldFocused: Bool
    
    let placeholder: String
    let minHeight: CGFloat = 30
    let textFont: UIFont
    let textcolor: UIColor

    var body: some View {
        VStack(alignment: .leading) {

            ZStack(alignment: .topLeading) {
                if text.isEmpty {
                    Text(placeholder)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 4)
                        .onTapGesture {
                            isTextFieldFocused = true
                    }
                }

                WrappedTextView(text: $text,
                                textDidChange: self.textDidChange,
                                textFont: textFont,
                                textcolor: textcolor)
                    .focused($isTextFieldFocused)
                    .frame(height: height ?? minHeight)
                    .limitInputLength(value: $text, length: 280)

            }
        }.onTapGesture {
            isTextFieldFocused = false
        }
    }
    
    private func textDidChange(_ textView: UITextView) {
        self.height = max(textView.contentSize.height, minHeight)
    }
}
