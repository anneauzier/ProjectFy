//
//  DetailsGroupView.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 09/08/23.
//

import SwiftUI

struct DetailsGroupView: View {
    @EnvironmentObject var viewModel: GroupViewModel
    
    let user: User
    let group: ProjectGroup
    
    @State private var goEditGroupView = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Image("\(group.avatar)")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Group {
                    Text("Group name")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("\(group.name)")
                        .font(.body)
                        .foregroundColor(.black)

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.rectangleLine)
                        .padding(.top, -15)

                    Text("Group description")
                        .font(.headline)
                        .foregroundColor(.black)
                    Text("\(group.description)")
                        .font(.body)
                        .foregroundColor(.black)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.rectangleLine)
                        .padding(.top, -15)
 
                    Text("Link for chat or/and meetings")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    if let url = URL(string: group.link) {
                        Link("\(group.link)", destination: url)
                    } else {
                        Text("No link available")
                            .font(.body)
                    }

                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.rectangleLine)
                        .padding(.top, -15)
                }
                
                Text("\(group.members.count + 1) Participants")
                    .font(.headline)
                    .foregroundColor(.black)
                
                RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                    UserInfo(user: group.admin, size: 49, nameColor: .white)
                        .frame(maxWidth: UIScreen.main.bounds.width - 60, alignment: .leading)
                        .removePadding()
                }
                .frame(height: 88)
                .padding(.bottom, -12)
                
                ForEach(group.members.map(\.user), id: \.self) { user in
                    RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                        UserInfo(user: user, size: 49, nameColor: .white)
                            .frame(maxWidth: UIScreen.main.bounds.width - 60, alignment: .leading)
                            .removePadding()
                    }
                    .frame(height: 88)
                }

            }.padding(.horizontal, 20)
            
            FinalButtons(user: user, group: group)
                .padding(.top, 60)
            
        }
        .toolbar {
            if group.admin.id == user.id {
                Button {
                    goEditGroupView.toggle()
                } label: {
                    Text("Edit")
                        .foregroundColor(.black)
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
        
        let user: User
        let group: ProjectGroup
        
        var body: some View {
            VStack {
                if group.admin.id == user.id {
                    Button {
                        print("FINALIZAR GRUPO")
                    } label: {
                        RoundedRectangleContent(cornerRadius: 16, fillColor: Color.textColorBlue) {
                            Text("Finalize project")
                                .font(Font.headline)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 56)
                }
                
                Button {
                    viewModel.exitGroup(user: user, group: group)
                } label: {
                    RoundedRectangleContent(cornerRadius: 16, fillColor: Color.unavailableText) {
                        Text("Exit group")
                            .font(Font.headline)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 40, height: 56)
            }
        }
    }
}
