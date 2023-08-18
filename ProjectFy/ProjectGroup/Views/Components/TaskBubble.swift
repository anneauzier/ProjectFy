//
//  TaskBubble.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 15/08/23.
//

import SwiftUI

struct TaskBubble: View {
    @Binding var tasks: ProjectGroup.Tasks

    var body: some View {
        VStack(alignment: tasks.received ? .leading : .trailing, spacing: 0) {

            Text("\(tasks.ownerID)")
                .padding()
                .font(.headline)
                .frame(maxWidth: 288)
                .foregroundColor(.white)
                .background(Color.black)

            ForEach(tasks.taskDescription, id: \.self) { message in
                Text(message)
                    .padding()
                    .frame(maxWidth: 288)
                    .background(tasks.received ? Color.orange : Color.green)
                Rectangle()
                    .frame(maxWidth: 288, maxHeight: 1)
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .cornerRadius(12)
        .frame(maxWidth: .infinity, alignment: tasks.received ? .leading : .trailing)
        .padding(tasks.received ? .leading : .trailing)

    }
}

// struct TaskBubble_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskBubble(tasks: ProjectGroup.Tasks(id: "6789", ownerID: "Iago Ramos",
//            taskDescription: ["n sei q sei q mais lá", "é sobre isso"],
//            received: false, time: Date()))
//    }
// }
