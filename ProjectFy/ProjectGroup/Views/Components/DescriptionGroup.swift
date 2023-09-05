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
                Text("Group description")
                    .font(.headline)
                    .foregroundColor(.backgroundRole)
                
                ZStack(alignment: .bottom) {
                    WrappedTextView(text: $groupInfo.description,
                                    textDidChange: self.textDidChange,
                                    textFont: UIFont.preferredFont(forTextStyle: .body),
                                    textcolor: UIColor(named: "backgroundRole") ?? .black)
                        .focused($isTextFieldFocused)
                        .frame(height: height ?? minHeight)
//                        .limitInputLength(value: $groupInfo.description, length: 100, commaLimit: 7)
 
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.rectangleLine)
                        .padding(.bottom, 3)
                
                    if groupInfo.description.isEmpty {
                        Text("Give a description to the group...")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray.opacity(0.7))
                            .padding(.bottom, 7)
                            .padding(.leading, 3)
                            .onTapGesture {
                                isTextFieldFocused = true
                            }
                    }
                }
            }
            .onTapGesture {
                isTextFieldFocused = false
            }
        }

        private func textDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.height = max(textView.contentSize.height, minHeight)
            }
        }
    }
}
