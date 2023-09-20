//
//  DetailsGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 09/08/23.
//

import SwiftUI

struct DetailsGroupView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    @Environment(\.dynamicTypeSize) var sizeCategory
    
    let user: User
    let refresh: () -> Void

    @State var group: ProjectGroup
    @State private var goEditGroupView = false

    @Binding var shouldRefresh: Bool
    @Binding var presentTasks: Bool
    @Binding var presentDetails: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Divider()
            VStack(alignment: .leading) {
                Image("\(group.avatar)")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 20)
                
                Text("\(group.name)")
                    .font(Font.title2.bold())
                    .foregroundColor(.backgroundRole)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .padding(.top, 12)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.rectangleLine)
                    .padding(.top, 20)
                
                VStack(alignment: .leading) {

                    Text("Group description")
                        .font(.headline)
                        .foregroundColor(.backgroundRole)
                        .padding(.top, 20)
                    
                    Text("\(group.description)")
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.body)
                        .foregroundColor(.backgroundRole)
                        .padding(.top, 12)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.rectangleLine)
                        .padding(.top, 20)
                    
                    Text("Link for chat or/and meetings")
                        .font(.headline)
                        .foregroundColor(.backgroundRole)
                        .padding(.top, 20)

                    if let url = URL(string: group.link) {
                        Link("\(group.link)", destination: url)
                            .font(.body)
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                .fill(Color.fieldColor)
                            ).padding(.top, 12)
                    } else {
                        Text("No link available")
                            .font(.body)
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.fieldColor)
                            ).padding(.top, 12)
                    }
                }
                
                Text("\(group.members.count + 1) Participant(s)")
                    .font(.title2.bold())
                    .foregroundColor(.backgroundRole)
                    .padding(.top, 40)
                
                    RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                        UserInfo(user: group.admin, size: 49, nameColor: .white)
                            .frame(maxWidth: UIScreen.main.bounds.width - 60, alignment: .leading)
                            .removePadding()
                            .padding(.vertical, 16)
                    }
                    
                    ForEach(group.members.map(\.user), id: \.self) { user in
                        RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                            UserInfo(user: user, size: 49, nameColor: .white)
                                .frame(maxWidth: UIScreen.main.bounds.width - 60, alignment: .leading)
                                .removePadding()
                        }.frame(height: 85)
                    }.padding(.top, sizeCategory.isAccessibilitySize ? 40 : 3)
            }.frame(maxWidth: UIScreen.main.bounds.width - 40)
            
            DetailsGroupButtons(
                user: user,
                group: $group,
                shouldRefresh: $shouldRefresh,
                refresh: refresh,
                presentDetails: $presentDetails,
                presentTasks: $presentTasks
            )
        }
        .toolbar {
            if group.admin.id == user.id {
                Button {
                    goEditGroupView.toggle()
                } label: {
                    Text("Edit")
                        .foregroundColor(.textColorBlue)
                }
                .sheet(isPresented: $goEditGroupView) {
                    EditDetailsGroup(group: group, viewModel: viewModel)
                }
            }
        }
        .onAppear {
            TabBarModifier.hideTabBar()
        }
    }
}
