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
    
    @State var isActive = false
    @State var selectedGroup: ProjectGroup?
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $isActive) {
                    if let group = selectedGroup {
                        DetailsGroupView(user: user, group: group)
                    }
                } label: {
                    EmptyView()
                }

                List {
                    ForEach(viewModel.groups, id: \.self) { group in
                        NavigationLink(
                            destination: TasksGroupView(group: group, user: user),
                            label: {
                                HStack {
                                    Image("\(group.avatar)")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    VStack(alignment: .leading) {
                                        Text("\(group.name)")
                                            .font(.headline)
                                            .foregroundColor(.backgroundRole)
                                        
                                        let names = group.members.map(\.user.name)
                                        
                                        Text("\(names.joined(separator: ", "))")
                                            .font(.subheadline)
                                            .foregroundColor(.editAdvertisementText)
                                    }
                                }
                            }
                        ).swipeActions {
                            Button(action: {
                                showActionSheet.toggle()
                            }, label: {
                                Image("points")
                            }).tint(.backgroundTextBlue)
                        }
                        .confirmationDialog("", isPresented: $showActionSheet, actions: {
                            Button {
                                selectedGroup = group
                                isActive = true
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

            }.navigationViewStyle(.stack)
            .navigationTitle("My Groups")
            .onAppear {
                TabBarModifier.showTabBar()
            }
        }
    }
}
