//
//  AdInfo.swift
//  ProjectFy
//
//  Created by Iago Ramos on 03/08/23.
//

import Foundation
import SwiftUI

extension AdView {
    struct AdInfo: View {
        @EnvironmentObject var userViewModel: UserViewModel
        
        let user: User
        let advertisement: Advertisement
        
        @State var presentSheet = false
        @State var selectedPosition: ProjectGroup.Position?
        
        var body: some View {
            VStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(advertisement.tags.split(separator: ","), id: \.self) { tag in
                            Tag(text: String(tag))
                        }
                    }
                }
                
                Text(advertisement.title)
                    .font(Font.largeTitle.bold())
                    .foregroundColor(.black)
                    .padding(.top, 10)
                
                HStack {
                    // if let weeklyWorkload = advertisement.weeklyWorkload {
                    //  Text("\(weeklyWorkload)h weekly")
                    // }
                    
                    Text(advertisement.ongoing ? "In progress" : "Not started")
                        .padding(5)
                        .font(.body)
                        .foregroundColor(.textColorYellow)
                        .background(Color.backgroundTextYellow)
                        .cornerRadius(8)
                }
                .removePadding()
                
                Text(advertisement.description)
                    .removePadding()
                    .padding(.top, 15)
                
                Text("Project roles")
                    .font(Font.title.bold())
                    .foregroundColor(.black)
                    .padding(.top, 15)
                
                VStack {
                    ForEach(advertisement.positions, id: \.self) { position in
                        Button {
                            selectedPosition = position
                            Haptics.shared.selection()
                        } label: {
                            Position(user: user, advertisement: advertisement, position: position)
                        }
                        
                        .onChange(of: selectedPosition, perform: { selectedPosition in
                            if selectedPosition != nil {
                                presentSheet = true
                            }
                        })
                        
                        .onChange(of: presentSheet) { presentSheet in
                            if !presentSheet {
                                selectedPosition = nil
                            }
                        }
                        
                        .sheet(isPresented: $presentSheet) {
                            if let position = selectedPosition {
                                PositionDetails(user: user, advertisement: advertisement, position: position)
                            } else {
                                Text("Position not found!")
                            }
                        }
                    }
                }
                Divider()
                
            }.frame(width: UIScreen.main.bounds.width - 40)
        }
    }
    
    private struct Tag: View {
        let text: String
        
        var body: some View {
            RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundTextBlue) {
                Text(text)
                    .padding(5)
                    .font(.callout)
                    .foregroundColor(.textColorBlue)
                    .lineLimit(0)
            }.padding(.top, 15)
        }
    }
    
    private struct Position: View {
        @EnvironmentObject var groupViewModel: GroupViewModel
        
        let user: User
        let advertisement: Advertisement
        let position: ProjectGroup.Position
        
        var body: some View {
            HStack(spacing: -20) {
                RoundedRectangleContent(cornerRadius: 8, fillColor: Color.textColorBlue) {
                    HStack(spacing: 12) {
                        Image(user.avatar)
                            .resizable()
                            .frame(width: 42, height: 42)
                        
                        var usersJoined: Int {
                            guard let group = groupViewModel.getGroup(by: advertisement.id) else {
                                return 0
                            }
                            
                            return group.members.count
                        }
                        
                        Text("\(usersJoined)/\(position.vacancies)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .scaledToFit()
                    }
                }
                .frame(width: 107)
                .zIndex(1)
                
                RoundedRectangleContent(cornerRadius: 8, fillColor: Color.roleBackground) {
                    Text(position.title)
                        .font(.headline)
                        .foregroundColor(.black)
                }
            }.frame(height: 60)
        }
    }
    
    private struct PositionDetails: View {
        @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
        @EnvironmentObject var groupViewModel: GroupViewModel
        @EnvironmentObject var notificationsViewModel: NotificationsViewModel
        
        let user: User
        let advertisement: Advertisement
        let position: ProjectGroup.Position
        
        @State var presentMaxGroupsAlert = false
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(position.title)
                    .font(Font.largeTitle.bold())
                    .foregroundColor(.black)
                
                var remainingVacancies: Int {
                    let vacancies = position.vacancies
                    
                    guard let group = groupViewModel.getGroup(by: advertisement.id) else {
                        return vacancies
                    }
                    
                    return vacancies - group.members.count
                }
                
                Text("\(remainingVacancies) remaining vacancies")
                    .padding(5)
                    .foregroundColor(.textColorBlue)
                    .background(Color.backgroundTextBlue)
                    .cornerRadius(8)
                    .removePadding()
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.2))
                
                Text("What will you do")
                    .font(Font.title.bold())
                    .foregroundColor(.black)
                    .padding(.bottom, 5)
                
                Text(position.description)
                    .padding(.top, -5)
                
                if let group = groupViewModel.getGroup(by: advertisement.id) {
                    Text("People who are already in this project role")
                        .font(Font.title.bold())
                        .foregroundColor(.black)
                        .removePadding()
                        .padding(.top, 37)
                    
                    ForEach(group.members.map(\.user), id: \.self) { user in
                        RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                            UserInfo(user: user, size: 49, nameColor: .white)
                            // TRATAR ESSA RESPONSIVIDADE DEPOIS
                                .padding(.trailing, 40)
                                .removePadding()
                        }.frame(height: 88)
                    }
                }
                
                Spacer()
                
                var isUserInTheGroup: Bool {
                    guard let group = groupViewModel.getGroup(by: advertisement.id) else {
                        return false
                    }
                    
                    if group.members.map(\.user).contains(where: { $0.id == user.id }) {
                        return true
                    }
                    
                    return false
                }
                
                if !isUserInTheGroup {
                    let application = advertisement.applications.first(where: { $0.user.id == user.id })
                    let hasApplied = application != nil
                    
                    var hasAppliedForThisPosition: Bool {
                        if let application = application, application.position.id == position.id {
                            return true
                        }
                        
                        return false
                    }
                    
                    let buttonText = hasAppliedForThisPosition ? "Remove request" : "Request to join"
                    let isDisabled = hasApplied && !hasAppliedForThisPosition
                    
                    let maxGroups = groupViewModel.groups.count >= 3
                    
                    Button {
                        if maxGroups {
                            Haptics.shared.notification(.error)
                            presentMaxGroupsAlert = true
                            
                            return
                        }
                        
                        advertisementsViewModel.applicationStatus = .applying
                        
                        if hasApplied {
                            advertisementsViewModel.unapply(user: user, of: advertisement, from: position)
                            notificationsViewModel.deleteRequestNotification(userID: user.id,
                                                                             advertisementID: advertisement.id)
                            
                            return
                        }
                        
                        advertisementsViewModel.apply(user: user, to: advertisement, for: position)
                        
                        let application = Advertisement.Application(id: UUID().uuidString,
                                                                    position: position,
                                                                    user: user)
                        
                        notificationsViewModel.pushRequestNotification(target: advertisement.owner,
                                                                       advertisement: advertisement,
                                                                       application: application)
                    } label: {
                        RoundedRectangleContent(cornerRadius: 8, fillColor: Color.textColorBlue) {
                            VStack {
                                if advertisementsViewModel.applicationStatus == .applying {
                                    ProgressView()
                                        .progressViewStyle(.circular)
                                } else {
                                    Text(buttonText)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                        }.frame(maxHeight: 60)
                         .padding(.top, 20)
                    }
                    .disabled(isDisabled)
                    
                    .simultaneousGesture(TapGesture().onEnded({ _ in
                        if isDisabled {
                            Haptics.shared.notification(.error)
                        }
                    }))
                }
            }.frame(width: UIScreen.main.bounds.width - 40)
            
            .onDisappear {
                advertisementsViewModel.applicationStatus = nil
            }
            
            .alert("You can't request to join beacause you are already in  three projects",
                   isPresented: $presentMaxGroupsAlert,
                   actions: {
                        Button(role: .cancel) {
                            presentMaxGroupsAlert = false
                        } label: {
                            Text("OK")
                        }
                   },
                   message: {
                        Text("you cannot participate in more than three projects at the same time")
                   }
            )
            
            .foregroundColor(.black)
            .padding(.top, 30)
        }
    }
}

struct RoundedRectangleContent<Content: View>: View {
    let cornerRadius: CGFloat
    let fillColor: Color
    
    let content: () -> Content
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(fillColor)
            
            content()
        }
        //        .fixedSize(horizontal: false, vertical: true)
    }
}
