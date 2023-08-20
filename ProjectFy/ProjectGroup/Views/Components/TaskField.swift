//
//  TaskField.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 15/08/23.
//

import SwiftUI

struct TaskField: View {
    @State var message: String = ""
    @Binding var task: ProjectGroup.Tasks

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
                    task.taskDescription.append(message)
                    message = ""
                    print("\(task.taskDescription)")
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(message.isEmpty ? Color.gray.opacity(0.2) : Color.black)
                        .cornerRadius(50)
                }.disabled(message.isEmpty)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
        }
    }
}

struct CustomTextField: View {
    @Binding var message: String
    var editingChanged: (Bool) -> Void = { _ in }
    var commit: () -> Void = {}
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("What did you do today?", text: $message, onEditingChanged: editingChanged, onCommit: commit)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.systemGray6))
                )
        }
    }
}

// struct TaskField_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var tasks = ProjectGroup.Tasks(id: "6789",
//                                              ownerID: "Iago Ramos",
//                                              taskDescription: ["n sei q sei q mais lá", "é sobre isso"],
//                                              received: false,
//                                              time: Date())
//        TaskField(task: $tasks)
//    }
// }
