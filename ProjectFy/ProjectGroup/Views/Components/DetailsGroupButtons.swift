//
//  DetailsGroupButtons.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 20/09/23.
//

import SwiftUI

extension DetailsGroupView {

    struct DetailsGroupButtons: View {

        @EnvironmentObject var viewModel: GroupViewModel
        @State private var showFinalizeAlert = false
        @State private var showExitAlert = false

        let user: User
        
        @Binding var group: ProjectGroup
        @Binding var shouldRefresh: Bool
        let refresh: () -> Void

        @Binding var presentDetails: Bool
        @Binding var presentTasks: Bool
        
        var body: some View {
            VStack {
                if !group.isFinished {
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
                        group.isFinished = true
                        
                        viewModel.editGroup(group)
                        shouldRefresh = true
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
            }
            .padding(.top, 110)

            .onChange(of: viewModel.groups) { _ in
                if let group = viewModel.getGroup(by: group.id) {
                    refresh()
                    return
                }
                
                viewModel.exitingStatus = .completed
                
                presentDetails = false
                presentTasks = false
                
                refresh()
            }
        }
    }
}
