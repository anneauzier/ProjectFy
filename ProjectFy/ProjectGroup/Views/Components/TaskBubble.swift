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
        VStack(alignment: tasks.user.id == currentUserID ? .leading : .trailing, spacing: 0) {
            Text("\(tasks.user.name)")
                .padding()
                .font(.headline)
                .frame(maxWidth: 288)
                .foregroundColor(.white)
                .background(Color.black)
            
            ForEach(tasks.taskDescription, id: \.self) { message in
                HStack {
                    Text(message)
                        .padding()
                        .frame(maxWidth: 288)
                        .background(tasks.user.id == currentUserID ? Color.orange : Color.green)
                        .overlay(alignment: .topTrailing) {
                            Text("\(tasks.date.formatted(.dateTime.hour().minute()))")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                        }
                }
                Rectangle()
                    .frame(maxWidth: 288, maxHeight: 1)
                    .foregroundColor(.gray.opacity(0.5))
            }
            
            Button("bkhbkhb") {
                print("\(tasks)")
            }
        }
        .cornerRadius(12)
        .frame(maxWidth: .infinity, alignment: tasks.user.id == currentUserID ? .leading : .trailing)
        .padding(tasks.user.id == currentUserID ? .leading : .trailing)
        
    }
}
