//
//  TasksGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct TasksGroupView: View {
    @State var task: ProjectGroup.Tasks

    let detailsInfo: ProjectGroup
    var viewModel: GroupViewModel
    let user: User
    
    init(task: ProjectGroup.Tasks, detailsInfo: ProjectGroup, viewModel: GroupViewModel, user: User) {
        self._task = State(initialValue: task)
        self.detailsInfo = detailsInfo
        self.viewModel = viewModel
        self.user = user
    }
    
    var body: some View {
        VStack {
            VStack {
                GroupInfo(detailsInfo: detailsInfo, viewModel: viewModel)
                
                ScrollView {
                    ForEach(detailsInfo.tasks, id: \.id) { task in
                        TaskBubble(tasks: task, currentUserID: user.id)
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                
            }.padding(.horizontal, 20)
            
            TaskField(task: $task)
        }.onAppear {
            TabBarModifier.hideTabBar()
        }
    }
}

struct GroupInfo: View {
    @State var detailsInfo: ProjectGroup
    var viewModel: GroupViewModel
    
    init(detailsInfo: ProjectGroup, viewModel: GroupViewModel) {
        self._detailsInfo = State(initialValue: detailsInfo)
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            NavigationLink {
                DetailsGroupView(groupInfo: $detailsInfo)
            } label: {
                HStack(alignment: .center) {
                    Image("\(detailsInfo.avatar)")
                        .resizable()
                        .frame(width: 71, height: 71)
                    VStack {
                        Text("\(detailsInfo.name)")
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

 struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        @State var tasks = ProjectGroup.Tasks(id: "6789", user: User(signInResult: .init(identityToken: "", nonce: "",
            name: "Iago", email: "")), taskDescription: ["n sei q sei q mais lá", "é sobre isso"], time: Date())
        TasksGroupView(task: tasks, detailsInfo: ProjectGroup(),
                       viewModel: GroupViewModel(service: GroupMockupService()), user: tasks.user)
    }
 }
