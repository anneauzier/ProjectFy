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
    
    init(service: GroupProtocol) {
        self.service = service
        
        service.getGroups { [weak self] groups in
            guard let groups = groups else { return }
            self?.groups = groups
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
}
