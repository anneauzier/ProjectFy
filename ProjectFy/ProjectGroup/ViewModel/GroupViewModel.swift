//
//  GroupViewModel.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

final class GroupViewModel: ObservableObject {

    @Published var groups: [ProjectGroup] = []
    @Published var exitingStatus: TransactionStatus?
    
    private let service: GroupProtocol
    private var allGroups: [ProjectGroup] = []
    
    private var userID: String?
    
    init(service: GroupProtocol) {
        self.service = service
        
        service.getGroups { [weak self] groups in
            guard let groups = groups else { return }
            
            self?.allGroups = groups
            
            self?.groups = groups.filter { group in
                group.members.contains { member in
                    member.user.id == self?.userID
                } ||
                
                group.admin.id == self?.userID
            }
        }
    }
    
    func createGroup(_ group: ProjectGroup) {
        do {
            try service.create(group)
        } catch {
            print("Cannot create group: \(error.localizedDescription)")
        }
    }
    
    func getGroup(with id: String) -> ProjectGroup? {
        return groups.first(where: { $0.id == id })
    }
    
    func getGroup(by positionID: String) -> ProjectGroup? {
        return allGroups.first { group in
            group.members.map(\.position).contains { position in
                position.id == positionID
            }
        }
    }
    
    func getGroups(from userID: String) -> [ProjectGroup] {
        return allGroups.filter { group in
            group.members.contains { member in
                member.user.id == userID
            }
        }
    }
    
    func editGroup(_ group: ProjectGroup) {
        do {
            try service.update(group)
        } catch {
            print("Cannot update advertisement: \(error)")
        }
    }
    
    func add(task: ProjectGroup.Task, to group: ProjectGroup) {
        service.add(task: task, on: group)
    }
    
    func changeAdmin(of group: ProjectGroup) {
        var group = group
        
        guard let newAdmin = group.members.map(\.user).randomElement() else {
            service.delete(with: group.id)
            return
        }
        
        group.admin = newAdmin
        group.members.removeAll(where: { $0.user.id == newAdmin.id })
        
        editGroup(group)
    }
    
    func exitOfGroup(user: User, group: ProjectGroup) {
        if group.admin.id == user.id {
            changeAdmin(of: group)
            return
        }
        
        guard let member = group.members.first(where: { $0.user.id == user.id }) else { return }
        
        service.remove(member: member, from: group) { [weak self] in
            DispatchQueue.main.async {
                self?.exitingStatus = .completed
            }
        }
    }
    
    func exitOfAllGroups() {
        var groupsIDs = groups.map(\.id)
        
        groupsIDs.forEach { [weak self] id in
            self?.deleteGroup(with: id)
        }
    }
    
    func deleteGroup(with id: String) {
        service.delete(with: id)
    }
    
    func setUser(with id: String) {
        self.userID = id
    }
}
