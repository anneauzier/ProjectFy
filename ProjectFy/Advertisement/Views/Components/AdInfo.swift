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
        
        @Binding var presentSheet: Bool
        @Binding var selectedPosition: ProjectGroup.Position?
        
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
                
                // Images
                //   LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2)) {
                //   ForEach(0..<4) { _ in
                //    RoundedRectangle(cornerRadius: 7)
                //     .frame(width: 177, height: 114)
                //    }
                //   }
                
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
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.rectangleLine)
                }
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
                        
                        let usersJoined = advertisement.applications.compactMap { $0 }
                        Text("\(usersJoined.count)/\(position.vacancies)")
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
//                .frame(width: 287)
            }.frame(height: 60)
        }
    }
    
    private struct PositionDetails: View {
        @EnvironmentObject var advertisementsViewModel: AdvertisementsViewModel
        @EnvironmentObject var userViewModel: UserViewModel
        @EnvironmentObject var notificationsViewModel: NotificationsViewModel
        
        let user: User
        let advertisement: Advertisement
        let position: ProjectGroup.Position
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(position.title)
                    .font(Font.largeTitle.bold())
                    .foregroundColor(.black)
                
                let usersJoined = advertisement.applications.compactMap { $0 }
                Text("\(position.vacancies - usersJoined.count) remaining vacancies")
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
                
                Text("People who are already in this project role")
                    .font(Font.title.bold())
                    .foregroundColor(.black)
                    .removePadding()
                    .padding(.top, 37)
                
                // BANCO DE DADOS
                
                RoundedRectangleContent(cornerRadius: 8, fillColor: Color.backgroundRole) {
                    UserInfo(user: user, size: 49, nameColor: .white)
                    // TRATAR ESSA RESPONSIVIDADE DEPOIS
                        .padding(.trailing, 40)
                        .removePadding()
                }.frame(height: 88)
                
                Spacer()
                
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
                
                Button {
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
            }.frame(width: UIScreen.main.bounds.width - 40)
            
            .onDisappear {
                advertisementsViewModel.applicationStatus = nil
            }
            
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
