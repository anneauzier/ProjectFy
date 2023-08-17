//
//  TaskBubble.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 15/08/23.
//

import SwiftUI

struct TaskBubble: View {

    var task: Task

    var body: some View {
        VStack(alignment: task.received ? .leading : .trailing, spacing: 0) {

            Text("\(task.senderName)")
                .padding()
                .font(.headline)
                .frame(maxWidth: 288)
                .foregroundColor(.white)
                .background(Color.black)

            ForEach(task.text, id: \.self) { message in
                Text(message)
                    .padding()
                    .frame(maxWidth: 288)
                    .background(task.received ? Color.orange : Color.green)
                Rectangle()
                    .frame(maxWidth: 288, maxHeight: 1)
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .cornerRadius(12)
        .frame(maxWidth: .infinity, alignment: task.received ? .leading : .trailing)
        .padding(task.received ? .leading : .trailing)

    }
}

struct TaskBubble_Previews: PreviewProvider {
    static var previews: some View {
        TaskBubble(task: Task(id: "1234",
                              senderName: "Iago Ramos",
                              text: ["Hello, word!", "É mesmo é", "nossaaaaa!!!!00000000000000000000000000000"],
                              received: false, time: Date()))
    }
}
