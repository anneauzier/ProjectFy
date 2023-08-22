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
                                viewModel: notificationsViewModel,
                                acceptedHandler: { notification in
                                    acceptAdvertisementRequest(notification: notification)
                                    deleteAdvertisementApplication(notification: notification)
                                    
                                    var acceptedNotification: InfoNotification {
                                        let targetID = notification.application.user.id
                                        let advertisement = notification.advertisement
                                        
                                        return InfoNotification(targetID: targetID, advertisement: advertisement)
                                    }
                                    
                                    notificationsViewModel.createNotification(acceptedNotification)
                                    
                                    let userID = notification.application.user.id
                                    
                                    if groupViewModel.getGroups(from: userID).count >= 3 {
                                        notificationsViewModel.deleteAllRequests(from: userID)
                                    }
                                }
                            )
                        } else if let infoNotification = notification as? InfoNotification {
                            NotificationComponent(notification: notification)
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
    
    var body: some View {
        HStack {
            Circle()
                .frame(width: 38, height: 38)
            
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
    
    init(notification: RequestNotification,
         viewModel: NotificationsViewModel,
         acceptedHandler: @escaping (RequestNotification) -> Void) {
        self._notification = State(initialValue: notification)
        
        self.viewModel = viewModel
        self.acceptedHandler = acceptedHandler
    }
    
    var body: some View {
        HStack {
            NotificationComponent(notification: notification)
            
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
