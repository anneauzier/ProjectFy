//
//  GroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

struct GroupView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    let user: User
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.groups, id: \.self) { group in
                        NavigationLink(destination: TasksGroupView(task: group.tasks[0],
                            detailsInfo: group, viewModel: viewModel, user: user)) {
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
                    }.swipeActions(edge: .trailing) {
                        Button {
                            print("INFOOO")
                        } label: {
                            Image(systemName: "info.circle")
                        }.tint(.blue)
                        
                        Button {
                            print("EXITTTTTTT")
                        } label: {
                            Image(systemName: "trash")
                        }
                    }.tint(.red)
                    
                }
            }.navigationTitle("My Groups")
             .onAppear {
                 TabBarModifier.showTabBar()
            }
        }
    }
}


// @State var isEditing: Bool = false
// @State var selectedRows: Set<String> = []

// struct GroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupView()
//            .environmentObject(GroupViewModel(service: GroupService()))
//    }
// }

//    .navigationBarItems(leading: cancelButton, trailing: editButton)
 //            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive))
 //            //            .animation(Animation.spring())
 //            .listStyle(InsetListStyle())

// var cancelButton: some View {
//    if isEditing {
//        return AnyView(Button("Cancelar") {
//            isEditing.toggle()
//            //                selectedRows.removeAll()
//        })
//    } else {
//        return AnyView(EmptyView())
//    }
// var editButton: some View {
//    return AnyView(Button(action: {
//        isEditing.toggle()
//        selectedRows.removeAll()
//    }) {
//        if isEditing {
//            Text("Deletar")
//        } else {
//            Image(systemName: "square.and.pencil")
//        }
//    })
// }
