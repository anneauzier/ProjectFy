//
//  CustomTextField.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 21/08/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var message: String
    var editingChanged: (Bool) -> Void = { _ in }
    var commit: () -> Void = {}
    var placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField(placeholder, text: $message, onEditingChanged: editingChanged, onCommit: commit)
                .padding(10)
                .autocorrectionDisabled(true)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.fieldColor)
                )
        }
    }
}
