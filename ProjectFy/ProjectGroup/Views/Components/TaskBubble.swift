//
//  TaskBubble.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 15/08/23.
//

import SwiftUI

struct TaskBubble: View {
    let user: User
    let isMyself: Bool
    var tasks: [ProjectGroup.Task]
    
    var body: some View {
        VStack(alignment: isMyself ? .trailing : .leading, spacing: 0) {
            Text(user.name)
                .padding()
                .font(.headline)
                .frame(maxWidth: 288)
                .foregroundColor(.white)
                .background(isMyself ? Color.textColorBlue : Color.backgroundRole)
            
            ForEach(tasks, id: \.self) { task in
                HStack {
                    Text(task.taskDescription)
                        .padding()
                        .frame(maxWidth: 288)
                        .background(isMyself ? Color.backgroundTextBlue : Color.bubbleColor)
                        .overlay(alignment: .topTrailing) {
                            Text("\(task.date.formatted(.dateTime.hour().minute()))")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                                .padding(.top, 5)
                        }
                }
                Rectangle()
                    .frame(maxWidth: 288, maxHeight: 1)
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .cornerRadius(12)
        .frame(maxWidth: .infinity, alignment: isMyself ? .trailing : .leading)
        .padding(isMyself ? .trailing : .leading)

    }
}
