//
//  GroupViewModel.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 08/08/23.
//

import SwiftUI

final class GroupViewModel: ObservableObject {

    @Published var groups: [ProjectGroup]
    let service: GroupProtocol

    init(service: GroupProtocol) {
        self.service = service
        self.groups = service.getGroups()
    }

    func getGroup(id: String) -> ProjectGroup? {
        return service.getGroup(id: id)
    }

    func createGroup(_ group: ProjectGroup) {
        service.createGroup(group)
        updateGroups()
    }

    func editGroup(_ group: ProjectGroup) {
        service.updateGroup(group)
        updateGroups()
    }

    func deleteGroup(id: String) {
        service.deleteGroup(id: id)
        updateGroups()
    }

    func updateGroups() {
        groups = service.getGroups()
    }
}
