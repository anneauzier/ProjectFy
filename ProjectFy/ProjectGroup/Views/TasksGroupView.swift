//
//  TasksGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct TasksGroupView: View {
//    @Binding var showTabBar: Bool
    @State var task: ProjectGroup.Tasks = ProjectGroup.Tasks(id: "123",
                                                             ownerID: "Iago Ramos",
                                                             taskDescription: ["Oi, galera", "tudo certo?"],
                                                             received: false,
                                                             time: Date())
    
    let detailsInfo: ProjectGroup
    var viewModel: GroupViewModel
    
    var body: some View {
        VStack {
            VStack {
                GroupInfo(detailsInfo: detailsInfo, viewModel: viewModel)
                
                ScrollView {
                    ForEach(detailsInfo.tasks, id: \.id) { task in
                        TaskBubble(tasks: $task)
                    }
                }
                .padding(.top, 10)
                .frame(maxWidth: .infinity)
                
            }.padding(.horizontal, 20)
            
            TaskField(task: $task)
        }
        //        .toolbar(showTabBar ? .visible : .hidden, for: .tabBar)
//        .onAppear {
//            showTabBar = false
//        }
    }
}

// struct MyPreviewProvider_Previews: PreviewProvider {
//    static var previews: some View {
//        @State var showTabBar: Bool = false
//        TasksGroupView(detailsInfo: ProjectGroup(),
//                       showTabBar: $showTabBar, viewModel: GroupViewModel(service: GroupMockupService()))
//    }
// }

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
                DetailsGroupView(detailsGroup: detailsInfo)
            } label: {
                HStack(alignment: .center) {
                    Image("\(detailsInfo.avatar)")
                        .resizable()
                        .frame(width: 71, height: 71)
                    VStack {
                        Text("\(detailsInfo.name)")
                            .font(.caption)
                        //                        Text("\(detailsInfo.members.count)")
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
