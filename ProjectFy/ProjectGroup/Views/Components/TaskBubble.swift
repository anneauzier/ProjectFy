//
//  TaskBubble.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 15/08/23.
//

import SwiftUI

struct TaskBubble: View {
    var tasks: ProjectGroup.Task
    var currentUserID: String
    
    var body: some View {
        VStack(alignment: tasks.user.id == currentUserID ? .trailing : .leading, spacing: 0) {
            Text("\(tasks.user.name)")
                .padding()
                .font(.headline)
                .frame(maxWidth: 288)
                .foregroundColor(.white)
                .background(tasks.user.id == currentUserID ? Color.textColorBlue : Color.black)
            
            ForEach(tasks.taskDescription, id: \.self) { message in
                HStack {
                    Text(message)
                        .padding()
                        .frame(maxWidth: 288)
                        .background(tasks.user.id == currentUserID ?
                                    Color.backgroundTextBlue : Color.bubbleColor)
                        .overlay(alignment: .topTrailing) {
                            Text("\(tasks.date.formatted(.dateTime.hour().minute()))")
                                .font(.caption2)
                                .foregroundColor(.gray)
                                .padding(.trailing, 10)
                        }
                }
                Rectangle()
                    .frame(maxWidth: 288, maxHeight: 1)
                    .foregroundColor(.gray.opacity(0.5))
            }
        }
        .cornerRadius(12)
        .frame(maxWidth: .infinity, alignment: tasks.user.id == currentUserID ? .trailing : .leading)
        .padding(tasks.user.id == currentUserID ? .trailing : .leading)
        
    }
}
