//
//  TaskField.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 15/08/23.
//

import SwiftUI

struct TaskField: View {
    @EnvironmentObject var viewModel: GroupViewModel
    
    let user: User
    let group: ProjectGroup
    @Binding var shouldRefresh: Bool
    
    @State var message: String = ""

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
                    let task = ProjectGroup.Task(user: user, description: message)
                    viewModel.add(task: task, to: group)
                    
                    message = ""
                    shouldRefresh.toggle()
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
}
