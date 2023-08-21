//
//  WrappedTextView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 10/08/23.
//

import SwiftUI

struct WrappedTextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    let textDidChange: (UITextView) -> Void // chamado sempre que o texto na UITextView for alterado.
    
    func makeUIView(context: Context) -> UITextView { // configurações básicas como a capacidade de edição e o delegado.
        let view = UITextView()
        view.isEditable = true
        view.delegate = context.coordinator
        
        view.font = UIFont.systemFont(ofSize: 16)
        
        return view
    }
    
    // é chamado sempre que a representação da view precisar ser atualizada.
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = self.text
        DispatchQueue.main.async {
            self.textDidChange(uiView)
        }
    }
    
    // garante que as alterações no texto sejam refletidas no binding e para acionar o closure textDidChange.
    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, textDidChange: textDidChange)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        @Binding var text: String
        let textDidChange: (UITextView) -> Void
        
        init(text: Binding<String>, textDidChange: @escaping (UITextView) -> Void) {
            self._text = text
            self.textDidChange = textDidChange
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.text = textView.text
            self.textDidChange(textView)
        }
    }
}

struct CustomText: View {
    let title: String
    @Binding var text: String
    @State var height: CGFloat?
    @FocusState var isTextFieldFocused: Bool
    
    let condition: Bool
    let placeholder: String
    let minHeight: CGFloat = 30
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            ZStack(alignment: .bottom) {
                WrappedTextView(text: $text, textDidChange: self.textDidChange)
                    .focused($isTextFieldFocused)
                    .frame(height: height ?? minHeight)
                    .limitInputLength(value: $text, length: 60, commaLimit: 7)
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.rectangleLine)
                if condition {
                    Text(placeholder)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.editAdvertisementText)
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
