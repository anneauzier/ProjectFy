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
    let group: ProjectGroup
    
    @State private var goEditGroupView = false
    
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
            
            FinalButtons(user: user, group: group)
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

extension DetailsGroupView {
    
    struct FinalButtons: View {
        @EnvironmentObject var viewModel: GroupViewModel
        @State private var showFinalizeAlert = false
        @State private var showExitAlert = false
        
        let user: User
        let group: ProjectGroup
        
        var body: some View {
            VStack {
                if group.admin.id == user.id {
                    Button {
                        showFinalizeAlert.toggle()
                    } label: {
                        RoundedRectangleContent(cornerRadius: 12, fillColor: Color.textColorBlue) {
                            Text("Finalize project")
                                .font(Font.headline)
                                .foregroundColor(.white)
                        }
                    }.frame(width: UIScreen.main.bounds.width - 40, height: 56)
                }
                
                Button {
                    showExitAlert.toggle()
                } label: {
                    RoundedRectangleContent(cornerRadius: 12, fillColor: Color.unavailableText) {
                        VStack {
                            if viewModel.exitingStatus == .sending {
                                ProgressView()
                                    .progressViewStyle(.circular)
                            } else {
                                Text("Exit group")
                                    .font(Font.headline)
                                    .foregroundColor(.white)
                            }
                        }
                    }.frame(width: UIScreen.main.bounds.width - 40, height: 56)
                }
                
                .alert("Do you really want to finalize this group?", isPresented: $showFinalizeAlert) {
                    Button(role: .cancel) {
                        showFinalizeAlert.toggle()
                    } label: {
                        Text("No, I don't")
                    }
                    
                    Button(role: .destructive) {
                        showFinalizeAlert.toggle()
                    } label: {
                        Text("Yes, I do")
                    }

                } message: {
                    Text("The team's work is considered finished and it will not be possible to send messages. This action is permanent and all team members have to agree.")
                        .multilineTextAlignment(.center)
                }
                
                .alert("Do you really want to exit this group?", isPresented: $showExitAlert) {
                    Button(role: .cancel) {
                        showExitAlert.toggle()
                    } label: {
                        Text("No, I don't")
                    }
                    
                    Button(role: .destructive) {
                        showExitAlert.toggle()
                        viewModel.exitingStatus = .sending
                        viewModel.exitOfGroup(user: user, group: group)
                    } label: {
                        Text("Yes, I do")
                    }

                } message: {
                    Text("You won't be able to rejoin the group unless you are request to join a project role again.")
                        .multilineTextAlignment(.center)
                }
            }.padding(.top, 110)
        }
    }
}
