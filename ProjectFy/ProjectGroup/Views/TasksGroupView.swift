//
//  TasksGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct TasksGroupView: View {
    
    @EnvironmentObject var viewModel: GroupViewModel
    @State var detailsInfo = ProjectGroup(id: "",
                                          name: "",
                                          description: "",
                                          avatar: "Group1",
                                          adminID: "",
                                          positions: [],
                                          link: "",
                                          tasks: [])
    let groupID: String
    
    var body: some View {
        
        VStack(alignment: .leading) {
            NavigationLink {
                DetailsGroupView(detailsInfo: detailsInfo)
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
                }
            }
        }
        .onAppear {
            if let groupInfo = viewModel.getGroup(id: groupID) {
                detailsInfo = groupInfo
            }
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        TasksGroupView(groupID: "1213")
            .environmentObject(GroupViewModel(service: GroupMockupService()))
    }
}
