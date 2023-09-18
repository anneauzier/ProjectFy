//
//  Position.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 14/09/23.
//

import SwiftUI

extension AdItemView {
    
    struct Position: View {
        @Environment(\.dynamicTypeSize) var sizeCategory
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
                            guard let group = groupViewModel.getGroup(by: position.id) else {
                                return 0
                            }
                            
                            let usersJoined = group.members.map(\.position).filter({ $0.id == position.id })
                            return usersJoined.count
                        }
                        
                        if sizeCategory.isAccessibilitySize {
                            Text("\(usersJoined)/\(position.vacancies)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .lineLimit(nil)
                        } else {
                            Text("\(usersJoined)/\(position.vacancies)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .scaledToFit()
                        }
                    }
                }.frame(width: UIScreen.main.bounds.width * 0.28)
                 .zIndex(1)
                
                RoundedRectangleContent(cornerRadius: 8, fillColor: Color.roleBackground) {
                    Text(position.title)
                        .font(.headline)
                        .foregroundColor(.backgroundRole)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, sizeCategory.isAccessibilitySize ? 30 : 25)
                }
                .environment(\.dynamicTypeSize, sizeCategory)
                .frame(height: sizeCategory.isAccessibilitySize ? nil : 70)
            }
        }
    }
    
    struct PositionDetails: View {
        @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
        @EnvironmentObject var groupViewModel: GroupViewModel
        @EnvironmentObject var notificationsViewModel: NotificationsViewModel

        @State var presentMaxGroupsAlert = false
        
        let user: User
        let advertisement: Advertisement
        let position: ProjectGroup.Position

        @Binding var updateAdvertisements: Bool

        var body: some View {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Text(position.title)
                            .font(Font.largeTitle.bold())
                            .foregroundColor(.backgroundRole)
                            .removePadding()
                        
                        var remainingVacancies: Int {
                            let vacancies = position.vacancies
                            
                            guard let group = groupViewModel.getGroup(by: position.id) else {
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
                            .padding(.top, 3)
                        
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray.opacity(0.2))
                            .padding(.top, 10)
                        
                        if !position.description.isEmpty {
                            Text("What will you do")
                                .font(Font.title.bold())
                                .foregroundColor(.backgroundRole)
                                .padding(.top, 10)
                            
                            Text(position.description)
                                .padding(.top, 10)
                        }
                        
                        if let group = groupViewModel.getGroup(by: position.id) {
                            VStack(alignment: .leading) {
                                Text("People already in this role ")
                                    .font(Font.title.bold())
                                    .foregroundColor(.backgroundRole)
                                    .removePadding()
                                    .padding(.top, 37)
                                
                                ForEach(group.members.map(\.user), id: \.self) { user in
                                    RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                                        UserInfo(user: user, size: 49, nameColor: .white)
                                            .frame(maxWidth: UIScreen.main.bounds.width - 80, alignment: .leading)
                                            .removePadding()
                                    }
                                    .frame(height: 88)
                                    .padding(.top, 6)
                                }
                                
                                Spacer()
                                
                                if group.members.map(\.user).contains(where: { $0.id == user.id }) {
                                    RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                                        Text("Joined")
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }.frame(height: 60)
                                     .padding(.top, 220)
                                }
                            }
                        } else {
                            VStack(alignment: .center) {
                                Text("People already in this role ")
                                    .font(Font.title.bold())
                                    .foregroundColor(.backgroundRole)
                                    .removePadding()
                                    .padding(.top, 37)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                CustomPlaceholder(image: Image("emptyAd"),
                                                     title: "There are no people in this role...",
                                                     description: "You can request to participate in this role by tapping on the request button below.",
                                                     height: 0.4)
                                .padding(.bottom, 50)
                            }.frame(width: UIScreen.main.bounds.width - 40)
                        }
                        
                        var isUserInTheGroup: Bool {
                            guard let group = groupViewModel.getGroup(by: position.id) else {
                                return false
                            }
                            
                            if group.members.map(\.user).contains(where: { $0.id == user.id }) {
                                return true
                            }
                            
                            return false
                        }
                        
                        Spacer()
                        
                        if let advertisement = advertisementsViewModel.getAdvertisement(with: position.advertisementID),
                           advertisement.owner.id != user.id, !isUserInTheGroup {
                            
                            let application = advertisement.applications.first(where: { $0.user.id == user.id })
                            let hasApplied = application != nil
                            
                            var hasAppliedForThisPosition: Bool {
                                if let application = application, application.position.id == position.id {
                                    return true
                                }
                                
                                return false
                            }
                            
                            let buttonText = hasAppliedForThisPosition ? "Cancel request" : "Request to join"
                            
                            let maxGroups = groupViewModel.groups.count >= 3
                            
                            var isPositionsFilled: Bool {
                                guard let group = groupViewModel.getGroup(by: position.id) else { return false }
                                let membersInThisPosition = group.members.filter({ $0.position.id == position.id }).count

                                return membersInThisPosition >= position.vacancies
                            }
                            
                            let isDisabled = (hasApplied && !hasAppliedForThisPosition)
                            || isUserInTheGroup || isPositionsFilled
                                                        
                            Button {
                                if maxGroups {
                                    Haptics.shared.notification(.error)
                                    presentMaxGroupsAlert = true
                                    
                                    return
                                }
                                
                                advertisementsViewModel.applicationStatus = .sending
                                
                                if hasApplied {
                                    advertisementsViewModel.unapply(user: user, of: advertisement, from: position)
                                    updateAdvertisements.toggle()
                                    
                                    notificationsViewModel.deleteRequestNotification(userID: user.id,
                                                                                     advertisementID: advertisement.id)
                                    return
                                }
                                
                                advertisementsViewModel.apply(user: user, to: advertisement, for: position)
                                updateAdvertisements.toggle()
                                
                                let application = Advertisement.Application(id: UUID().uuidString,
                                                                            position: position,
                                                                            user: user)
                                
                                notificationsViewModel.pushRequestNotification(target: advertisement.owner,
                                                                               advertisement: advertisement,
                                                                               application: application)
                            } label: {
                                RoundedRectangleContent(cornerRadius: 8, fillColor: hasAppliedForThisPosition ?
                                                        Color.backgroundTextBlue : Color.textColorBlue) {
                                    VStack {
                                        if advertisementsViewModel.applicationStatus == .sending {
                                            ProgressView()
                                                .progressViewStyle(.circular)
                                        } else {
                                            Text(buttonText)
                                                .font(.headline)
                                                .foregroundColor(hasAppliedForThisPosition ? .textColorBlue : .white)
                                        }
                                    }
                                }.frame(height: 60)
                            }
                            .disabled(isDisabled)
                            .buttonStyle(.plain)
                            
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
                    
                        .alert("You can't request to join because you are already in three projects!",
                               isPresented: $presentMaxGroupsAlert,
                               actions: {
                            Button(role: .cancel) {
                                presentMaxGroupsAlert = false
                            } label: {
                                Text("OK")
                            }
                        }, message: {
                            Text("You cannot participate in more than three projects at the same time.")
                        })
                        .foregroundColor(.backgroundRole)
                        .padding(.top, 30)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Role Description")
                }.frame(width: UIScreen.main.bounds.width)
            }
        }
    }
}