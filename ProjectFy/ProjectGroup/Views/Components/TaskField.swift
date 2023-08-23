//
//  TaskField.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 15/08/23.
//

import SwiftUI

struct TaskField: View {
    @State var group: ProjectGroup
    @State var task: ProjectGroup.Task
    var viewModel: GroupViewModel
    
    @State var message: String = ""
    
    init(user: User, group: ProjectGroup, viewModel: GroupViewModel) {
        self._group = State(initialValue: group)
        self.viewModel = viewModel
        
        if let task = group.tasks.first(where: { $0.user.id == user.id }) {
            self._task = State(initialValue: task)
            return
        }
        
        self._task = State(initialValue: ProjectGroup.Task(user: user))
    }

    var body: some View {
        VStack {
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray.opacity(0.2))
            
            HStack {
                CustomTextField(message: $message, placeholder: "What did you do today?")
                    .frame(height: 37)
                    .cornerRadius(8)
                
                Button {
                    task.taskDescription.append(message)
                    message = ""
                    
                    updateTasks()
                    viewModel.editGroup(group)
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(message.isEmpty ? Color.editAdvertisementText : Color.textColorBlue)
                        .cornerRadius(50)
                }.disabled(message.isEmpty)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
        }
    }
    
    private func updateTasks() {
        if !group.tasks.contains(where: { $0.id == task.id }) {
            group.tasks.append(task)
            return
        }
        
        guard let index = group.tasks.firstIndex(where: { $0.id == task.id }) else { return }
        group.tasks[index] = task
    }
}
