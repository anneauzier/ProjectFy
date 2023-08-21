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
    @State private var selection: ProjectGroup?
    let user: User
    
    @State var isActive = false
    @State var selectedGroup: ProjectGroup?
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $isActive) {
                    if let group = selectedGroup {
                        DetailsGroupView(group: group)
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
                                            .font(.subheadline)
                                        // Text("\(group.members.count) participants")
                                    }
                                }
                            }
                        ).swipeActions {
                            Button(action: {
                                showActionSheet.toggle()
                            }, label: {
                                Text("...")
                                    .foregroundColor(.black)
                            })
                        }
                        .confirmationDialog("", isPresented: $showActionSheet, titleVisibility: .visible) {
                            Button {
                                selectedGroup = group
                                isActive = true
                            } label: {
                                Label("Group info", systemImage: "info.circle")
                            }

                            Button(role: .destructive) {
                                selection = group
                            } label: {
                                Text("Exit group")
                            }
                        }
                    }
                }
            }.navigationViewStyle(.stack)
            .navigationTitle("My Groups")
            .onAppear {
                TabBarModifier.showTabBar()
            }
        }
    }
}
