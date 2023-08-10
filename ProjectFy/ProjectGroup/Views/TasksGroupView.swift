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
                                          avatar: "",
                                          adminID: "",
                                          members: [:],
                                          link: "",
                                          tasks: [])
    let id: String
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Button {
                    print("TOQUEIIII")
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
                    }
                }
                Spacer()
            }
        }
        .onAppear {
            if let groupInfo = viewModel.getGroup(id: id) {
                detailsInfo = groupInfo
            }
        }
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        TasksGroupView(id: "1213")
            .environmentObject(GroupViewModel(service: GroupMockupService()))
    }
}
