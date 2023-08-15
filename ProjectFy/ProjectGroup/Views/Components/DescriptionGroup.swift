//
//  DescriptionGroup.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 11/08/23.
//

import SwiftUI

extension EditDetailsGroup {
    
    struct DescriptionGroup: View {
        @FocusState var isTextFieldFocused: Bool
        @State private var height: CGFloat?
        @Binding var groupInfo: ProjectGroup

        let minHeight: CGFloat = 30
    
        var body: some View {
            VStack(alignment: .leading) {
                Text("Description")
                ZStack(alignment: .bottom) {
                    WrappedTextView(text: $groupInfo.description, textDidChange: self.textDidChange)
                        .focused($isTextFieldFocused)
                        .frame(height: height ?? minHeight)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray.opacity(0.2))
                    
                    if groupInfo.description.isEmpty {
                        Text("Digite algo...")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray.opacity(0.7))
                            .padding(.bottom, 7)
                            .padding(.leading, 3)
                            .onTapGesture {
                                isTextFieldFocused = true
                            }
                    }
                }
            }.onTapGesture {
                isTextFieldFocused = false
            }
        }

        private func textDidChange(_ textView: UITextView) {
            self.height = max(textView.contentSize.height, minHeight)
        }
    }
}