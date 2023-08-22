//
//  Notifications.swift
//  ProjectFy
//
//  Created by Iago Ramos on 21/08/23.
//

import Foundation
import SwiftUI

struct Notifications: View {
    @EnvironmentObject var notificationsViewModel: NotificationsViewModel
    @EnvironmentObject var advertisementViewModel: AdvertisementsViewModel
    @EnvironmentObject var groupViewModel: GroupViewModel
    
    let user: User
    
    var body: some View {
        NavigationView {
            List {
                ForEach(notificationsViewModel.notifications, id: \.id) { notification in
                    VStack {
                        if let requestNotification = notification as? RequestNotification,
                           requestNotification.accepted == nil {
                            
                            AcceptableNotification(
                                notification: requestNotification,
                                viewModel: notificationsViewModel, user: user,
                                acceptedHandler: { notification in
                                    acceptAdvertisementRequest(notification: notification)
                                    deleteAdvertisementApplication(notification: notification)
                                    
                                    let userID = notification.application.user.id
                                    
                                    if groupViewModel.getGroups(from: userID).count >= 3 {
                                        notificationsViewModel.deleteAllRequests(from: userID)
                                    }
                                }
                            )
                        } else {
                            NotificationComponent(notification: notification, user: user)
                        }
                    }
                    
                    .swipeActions(allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            notificationsViewModel.delete(with: notification.id)
                        } label: {
                            Label("delete", systemImage: "trash")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                Button {
                    notificationsViewModel.notifications.forEach {
                        notificationsViewModel.delete(with: $0.id)
                    }
                } label: {
                    Text("Clear All")
                }
            }
        }
    }
    
    private func acceptAdvertisementRequest(notification: RequestNotification) {
        guard let accepted = notification.accepted, accepted else { return }
        let advertisement = notification.advertisement
        
        if var group = groupViewModel.groups.first(where: { $0.advertisement.id == advertisement.id }) {
            group.members.append(notification.application)
            groupViewModel.editGroup(group)
            
            return
        }
        
        var group = ProjectGroup(advertisement: advertisement)
        
        group.members.append(notification.application)
        groupViewModel.createGroup(group)
    }
    
    private func deleteAdvertisementApplication(notification: RequestNotification) {
        var advertisement = notification.advertisement
        
        advertisement.applications.removeAll(where: { $0.id == notification.application.id })
        advertisementViewModel.editAdvertisement(advertisement)
    }
}

fileprivate struct NotificationComponent: View {
    let notification: any Notification
    let user: User
    
    var body: some View {
        HStack {
            Image(user.avatar)
                .resizable()
                .frame(width: 39, height: 39)
            
            Group {
                Text(.init(notification.appBody)) +
                
                Text(" " + notification.date.formattedInterval)
                    .foregroundColor(.gray)
            }
            .font(.subheadline)
            .padding(.leading, 9)
        }
    }
}

fileprivate struct AcceptableNotification: View {
    @State var notification: RequestNotification
    
    var viewModel: NotificationsViewModel
    var acceptedHandler: (RequestNotification) -> Void
    let user: User
    
    init(notification: RequestNotification,
         viewModel: NotificationsViewModel, user: User,
         acceptedHandler: @escaping (RequestNotification) -> Void) {
        self._notification = State(initialValue: notification)
        
        self.viewModel = viewModel
        self.user = user
        self.acceptedHandler = acceptedHandler
    }
    
    var body: some View {
        HStack {
            NotificationComponent(notification: notification, user: user)
            
            HStack {
                Button {
                    notification.accepted = true
                    
                    viewModel.editNotification(notification)
                    acceptedHandler(notification)
                } label: {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                }
                .buttonStyle(.plain)

                Button {
                    notification.accepted = false
                    viewModel.editNotification(notification)
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                }
                .buttonStyle(.plain)
            }
            .padding(.leading, 20)
        }
    }
}
