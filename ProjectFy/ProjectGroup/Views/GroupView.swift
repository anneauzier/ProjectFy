//
//  GroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct GroupView: View {
    let user: User
    @State var viewModel: GroupViewModel
    
    @StateObject var groups: Refreshable<GroupViewModel, [ProjectGroup]>
    @State var shouldRefresh = false
    
    init(user: User, viewModel: GroupViewModel) {
        self.user = user
        self._viewModel = State(initialValue: viewModel)

        self._groups = StateObject(wrappedValue: Refreshable(observe: viewModel, keyPath: \.groups))
    }
    
    @State var selectedGroup: ProjectGroup?
    
    @State private var showActionSheet = false
    @State var isTasksActive = false
    @State var isDetailsActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                GroupLink(isActive: $isTasksActive, selectedGroup: selectedGroup) { group in
                    TasksGroupView(
                        group: group,
                        user: user,
                        refresh: groups.refresh,
                        shouldRefresh: $shouldRefresh,
                        isTasksActive: $isTasksActive,
                        isDetailsActive: $isDetailsActive
                    )
                }
                
                List {
                    ForEach(groups[], id: \.self) { group in
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
                                selectedGroup = group
                                isDetailsActive = true
                            } label: {
                                Label("Group info", systemImage: "info.circle")
                            }
                            
                            Button(role: .destructive) {
                                viewModel.exitOfGroup(user: user, group: group)
                                shouldRefresh = true
                                
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
                    groups.refresh()
                }
            }
            .navigationViewStyle(.stack)
            .navigationTitle("My Groups")
            
            .onAppear {
                TabBarModifier.showTabBar()
            }
            
            .onChange(of: viewModel.groups) { groups in
                if shouldRefresh {
                    self.groups.refresh()
                    shouldRefresh.toggle()
                }
                
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
}

struct GroupLink<Content: View>: View {
    @Binding var isActive: Bool
    
    let selectedGroup: ProjectGroup?
    let content: (ProjectGroup) -> Content
    
    init(isActive: Binding<Bool>,
         selectedGroup: ProjectGroup?,
         content: @escaping (ProjectGroup) -> Content) {
        self._isActive = isActive
        self.selectedGroup = selectedGroup
        self.content = content
    }
    
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
