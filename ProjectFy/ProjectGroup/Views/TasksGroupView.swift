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
                GroupInfo(group: group)
                
                ScrollView {
                    ForEach(group.tasks, id: \.id) { task in
                        TaskBubble(tasks: task, currentUserID: user.id)
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                
            }.padding(.horizontal, 20)
            
            TaskField(user: user, group: group, viewModel: viewModel)
        }
        .onAppear {
            TabBarModifier.hideTabBar()
        }
    }
}

struct GroupInfo: View {
    @EnvironmentObject var viewModel: GroupViewModel
    let group: ProjectGroup
    
    var body: some View {
        VStack {
            NavigationLink {
                DetailsGroupView(group: group)
            } label: {
                HStack(alignment: .center) {
                    Image("\(group.avatar)")
                        .resizable()
                        .frame(width: 71, height: 71)
                    VStack {
                        Text("\(group.name)")
                            .font(.caption)
//                      Text("\(detailsInfo.members.count)")
                    }.foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.black)
                }.navigationBarTitleDisplayMode(.inline)
            }
        }

        Divider()
    }
}
