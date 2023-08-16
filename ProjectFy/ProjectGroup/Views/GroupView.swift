//
//  GroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct GroupView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.groups, id: \.self) { group in
                        NavigationLink(destination: TasksGroupView(detailsInfo: group, viewModel: viewModel)) {
                            HStack {
                                Image("\(group.avatar)")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                VStack(alignment: .leading) {
                                    Text("\(group.name)")
                                        .font(.subheadline)
//                                    Text("\(group.members.count) participants")
                                }
                            }
                        }
                    }
                }
            }.navigationTitle("My Groups")
        }
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView()
            .environmentObject(GroupViewModel(service: GroupService()))
    }
}
