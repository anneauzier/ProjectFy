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
                    if group.tasks.isEmpty {
                        Text("Today")
                            .padding(8)
                            .font(.subheadline)
                            .foregroundColor(.textColorBlue)
                            .background(Color.backgroundTextBlue)
                            .cornerRadius(8)
                    } else {
                        var members: [User] {
                            var members = [group.admin]
                            members.append(contentsOf: group.members.map(\.user))
                            
                            guard let myIndex = members.firstIndex(where: { $0.id == user.id }) else {
                                return members
                            }
                            
                            members.append(members.remove(at: myIndex))
                            return members
                        }
                        
                        ForEach(members, id: \.id) { user in
                            let tasks = group.tasks.filter({ $0.user.id == user.id })
                            
                            if !tasks.isEmpty {
                                TaskBubble(user: user, isMyself: user.id == self.user.id, tasks: tasks)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
            }
            if group.isFinish {
                TaskField(user: user, group: group)
                    .disabled(true)
            } else {
                TaskField(user: user, group: group)
            }
            
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
                            .multilineTextAlignment(.leading)
                        
                        var names: [String] {
                            var users = group.members.map(\.user)
                            
                            users.insert(group.admin, at: 0)
                            users.removeAll(where: { $0.id == user.id })
                            
                            var names = users.map(\.name)
                            names.insert("You", at: 0)
                            
                            return names
                        }
                        
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
