//
//  TasksGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct TasksGroupView: View {
    @State var detailsInfo: ProjectGroup
    var viewModel: GroupViewModel
    
    init(detailsInfo: ProjectGroup, viewModel: GroupViewModel) {
        self._detailsInfo = State(initialValue: detailsInfo)
        self.viewModel = viewModel
    }
    
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
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        TasksGroupView(detailsInfo: ProjectGroup(), viewModel: GroupViewModel(service: GroupMockupService()))
    }
}
