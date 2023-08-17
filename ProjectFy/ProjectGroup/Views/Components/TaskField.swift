//
//  TaskField.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 15/08/23.
//

import SwiftUI

struct TaskField: View {
    @State var message: String = ""
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.2))

            HStack {
                CustomTextField(message: $message)
                    .frame(height: 37)
                    .cornerRadius(8)
                
                Button {
                    // messagesManager.sendMessage(text: message)
                    message = ""
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Color.black)
                        .cornerRadius(50)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
            
        }
    }
}

struct TaskField_Previews: PreviewProvider {
    static var previews: some View {
        TaskField()
    }
}

struct CustomTextField: View {
    
    @Binding var message: String
    var editingChanged: (Bool) -> Void = { _ in }
    var commit: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("What did you today?", text: $message, onEditingChanged: editingChanged, onCommit: commit)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray6))
                )
        }
    }
}
