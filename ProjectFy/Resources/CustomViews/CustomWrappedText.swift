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

            ZStack(alignment: .bottom) {
                WrappedTextView(text: $text,
                                textDidChange: self.textDidChange,
                                textFont: textFont,
                                textcolor: textcolor)
                    .focused($isTextFieldFocused)
                    .frame(height: height ?? minHeight)

                if text.isEmpty {
                    Text(placeholder)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 7)
                        .padding(.leading, 3)
                        .onTapGesture {
                            isTextFieldFocused = true
                    }
                }
            }
            .padding(.top, -3)
        }.onTapGesture {
            isTextFieldFocused = false
        }
    }
    
    private func textDidChange(_ textView: UITextView) {
        self.height = max(textView.contentSize.height, minHeight)
    }
}
