//
//  GroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct GroupView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    @State private var showActionSheet = false
    
    let user: User
    
    @State var isTasksActive = false
    @State var isDetailsActive = false
    @State var selectedGroup: ProjectGroup?
    
    var body: some View {
        NavigationView {
            VStack {
                Link(isActive: $isTasksActive, selectedGroup: $selectedGroup) { group in
                    TasksGroupView(group: group, user: user)
                }
                
                Link(isActive: $isDetailsActive, selectedGroup: $selectedGroup) { group in
                    DetailsGroupView(user: user, group: group)
                }
                
                if viewModel.groups.isEmpty {
                    StructurePlaceholder(image: Image("emptyAd"),
                                 title: "You don't have any \ngroups yet :(",
                                 description: "Join a group asking for a role in a \nproject announce",
                                 heightPH: 0.7)
                } else {
                    List {
                        ForEach(viewModel.groups, id: \.self) { group in
                            Button {
                                selectedGroup = group
                                isTasksActive = true
                            } label: {
                                HStack(spacing: 10) {
                                    Image("\(group.avatar)")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    VStack(alignment: .leading) {
                                        Text("\(group.name)")
                                            .font(.headline)
                                            .foregroundColor(.backgroundRole)
                                        
                                        if group.isFinish {
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
                                    selectedGroup = group
                                    isDetailsActive = true
                                } label: {
                                    Label("Group info", systemImage: "info.circle")
                                }
                                
                                Button(role: .destructive) {
                                    viewModel.exitOfGroup(user: user, group: group)
                                } label: {
                                    Text("Exit group")
                                }
                            })
                        }
                    }.listStyle(.plain)
                }

            }
            .navigationViewStyle(.stack)
            .navigationTitle("My Groups")
            
            .onAppear {
                TabBarModifier.showTabBar()
            }
            
            .onChange(of: viewModel.groups) { groups in
                guard let group = selectedGroup else { return }
                
                guard let updatedGroup = groups.first(where: { $0.id == group.id }) else {
                    selectedGroup = nil
                    
                    isTasksActive = false
                    isDetailsActive = false
                    
                    return
                }
                
                if updatedGroup == group {
                    return
                }
                
                selectedGroup = updatedGroup
            }
        }
    }
    
    struct Link<Content: View>: View {
        @Binding var isActive: Bool
        @Binding var selectedGroup: ProjectGroup?
        
        let content: (ProjectGroup) -> Content
        
        var body: some View {
            NavigationLink(isActive: $isActive) {
                if let group = selectedGroup {
                    content(group)
                }
            } label: {
                EmptyView()
            }

        }
    }
}
