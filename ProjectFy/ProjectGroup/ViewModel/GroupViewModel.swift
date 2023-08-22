//
//  GroupViewModel.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

final class GroupViewModel: ObservableObject {
    
    @Published var groups: [ProjectGroup] = []
    
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
    
    func getGroup(by advertisementID: String) -> ProjectGroup? {
        return allGroups.first(where: { $0.advertisement.id == advertisementID })
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
    
    func deleteGroup(with id: String) {
        service.delete(with: id)
    }
    
    func setUser(with id: String) {
        self.userID = id
    }
}
