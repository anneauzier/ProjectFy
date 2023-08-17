//
//  TasksGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct TasksGroupView: View {
    
    @EnvironmentObject var viewModel: GroupViewModel
    @ObservedObject var taskMockup = TasksMockupService()
    @Binding var showTabBar: Bool

    let groupID: String

    var body: some View {
        VStack {
            VStack {
                GroupInfo(groupID: groupID)
                
                ScrollView {
                    ForEach(taskMockup.messages, id: \.id) { task in
                        TaskBubble(task: task)
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)

            }.padding(.horizontal, 20)

            TaskField()
        }
        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
        .onAppear {
            showTabBar = false
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        @State var showTabBar: Bool = false

        TasksGroupView(showTabBar: $showTabBar, groupID: "1213")
            .environmentObject(GroupViewModel(service: GroupMockupService()))
    }
}

struct GroupInfo: View {
    
    @EnvironmentObject var viewModel: GroupViewModel
    @State var detailsInfo = ProjectGroup(id: "",
                                          name: "",
                                          description: "",
                                          avatar: "Group1",
                                          adminID: "",
                                          members: [:],
                                          link: "",
                                          tasks: [])
    let groupID: String
    
    var body: some View {
        VStack {
            NavigationLink {
                DetailsGroupView(detailsGroup: detailsInfo)
            } label: {
                HStack(alignment: .center) {
                    Image("\(detailsInfo.avatar)")
                        .resizable()
                        .frame(width: 71, height: 71)
                    VStack {
                        Text("\(detailsInfo.name)")
                            .font(.caption)
                        Text("\(detailsInfo.members.count)")
                    }.foregroundColor(.black)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .foregroundColor(.black)
                }.navigationBarTitleDisplayMode(.inline)
            }
        }
        Divider()

            .onAppear {
                if let groupInfo = viewModel.getGroup(id: groupID) {
                    detailsInfo = groupInfo
                }
            }
    }
}
