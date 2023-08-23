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
                
                Text("\(group.members.count + 1) Participants")
                    .font(.title2.bold())
                    .foregroundColor(.backgroundRole)
                    .padding(.top, 40)
                
                ForEach(group.members.map(\.user), id: \.self) { user in
                    RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                        UserInfo(user: user, size: 49, nameColor: .white)
                            .frame(maxWidth: UIScreen.main.bounds.width - 60, alignment: .leading)
                            .removePadding()
                    }
                    .frame(height: 85)
                }
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
                    viewModel.exitOfGroup(user: user, group: group)
                } label: {
                    RoundedRectangleContent(cornerRadius: 16, fillColor: Color.unavailableText) {
                        Text("Exit group")
                            .font(Font.headline)
                            .foregroundColor(.white)
                    }
                }
                .frame(width: UIScreen.main.bounds.width - 40, height: 56)
            }.padding(.top, 110)
        }
    }
}
