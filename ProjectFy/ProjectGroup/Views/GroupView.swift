//
//  GroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct GroupView: View {
    @EnvironmentObject var coordinator: Coordinator<GroupsRouter>
    @EnvironmentObject var viewModel: GroupViewModel
    
    let user: User
    
    @State private var showActionSheet = false
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.groups, id: \.self) { group in
                    Button {
                        coordinator.show(.tasks(user, group))
                    } label: {
                        HStack(spacing: 10) {
                            Image("\(group.avatar)")
                                .resizable()
                                .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text("\(group.name)")
                                    .font(.headline)
                                    .foregroundColor(.backgroundRole)
                                
                                if group.isFinished {
                                    Text("This project was finalized")
                                        .font(.subheadline)
                                        .foregroundColor(.editAdvertisementText)
                                } else {
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
                            }
                        }
                    }
                    .swipeActions {
                        Button(action: {
                            showActionSheet.toggle()
                        }, label: {
                            Image("points")
                        }).tint(.backgroundTextBlue)
                    }
                    .confirmationDialog("", isPresented: $showActionSheet, actions: {
                        Button {
                            coordinator.show(.groupDetails(user, group))
                        } label: {
                            Label("Group info", systemImage: "info.circle")
                        }
                        
                        Button(role: .destructive) {
                            viewModel.refreshGroups()
                            viewModel.exitOfGroup(user: user, group: group)
                            
                        } label: {
                            Text("Exit group")
                        }
                    })
                }
                
                if viewModel.groups.isEmpty {
                    StructurePlaceholder(image: Image("emptyAd"),
                                         title: "You don't have any \ngroups yet :(",
                                         description: "Join a group asking for a role in a \nproject announce",
                                         heightPH: 0.7)
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .listStyle(.plain)
            .refreshable {
                viewModel.refreshGroups()
            }
        }
        .navigationViewStyle(.stack)
        .navigationTitle("My Groups")
        
        .onAppear {
            TabBarModifier.showTabBar()
        }
    }
}
