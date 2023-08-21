//
//  GroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct GroupView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    @State private var showBottomSheet = false
    @State private var selection = ""
    let user: User
    
    var body: some View {
        NavigationView {
            VStack {
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
                                showBottomSheet.toggle()
                            }, label: {
                                Text("...")
                                    .foregroundColor(.black)
                            })
                        }
                    }
                }.confirmationDialog("Select Color", isPresented: $showBottomSheet, titleVisibility: .visible) {
                    Button {
                        selection = "Group info"
                    } label: {
                        Label("Group info", systemImage: "info.circle")
                    }
                    Button {
                        selection = "Exit group"
                    } label: {
                        Label("Exit group", systemImage: "iphone.and.arrow.forward")
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationViewStyle(.stack)
            .navigationTitle("My Groups")
            
            .onAppear {
                TabBarModifier.showTabBar()
            }
        }
    }
}
