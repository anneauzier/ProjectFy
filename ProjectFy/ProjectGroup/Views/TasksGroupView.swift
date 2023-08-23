//
//  TasksGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct TasksGroupView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    
    let group: ProjectGroup
    let user: User
    
    var body: some View {
        VStack {
            VStack {
                GroupInfo(user: user, group: group)
                
                ScrollView {
                    ForEach(group.tasks, id: \.id) { task in
                        TaskBubble(tasks: task, currentUserID: user.id)
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
            }

            TaskField(user: user, group: group, viewModel: viewModel)
        }
        .onAppear {
            TabBarModifier.hideTabBar()
        }
    }
}

struct GroupInfo: View {
    @EnvironmentObject var viewModel: GroupViewModel
    
    let user: User
    let group: ProjectGroup
    
    var body: some View {
        VStack {
            NavigationLink {
                DetailsGroupView(user: user, group: group)
            } label: {
                HStack(alignment: .center, spacing: 10) {
                    Image("\(group.avatar)")
                        .resizable()
                        .frame(width: 71, height: 71)
                    VStack(alignment: .leading) {
                        Text("\(group.name)")
                            .font(.headline)
                            .foregroundColor(.backgroundRole)
                        
                        let names = group.members.map(\.user.name)
                        
                        Text("\(names.joined(separator: ", "))")
                            .font(.subheadline)
                            .foregroundColor(.editAdvertisementText)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.backgroundRole)
                }.padding(.horizontal, 15)
                .navigationBarTitleDisplayMode(.inline)
            }
        }

        Divider()
    }
}
