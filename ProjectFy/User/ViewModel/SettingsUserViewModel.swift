//
//  SettingsUserViewModel.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 07/08/23.
//

import Foundation

final class SettingsUserViewModel: ObservableObject {

    @Published var user: User?

    private let service: UserProtocol
    
    init(service: UserProtocol) {
        self.service = service
    }
    
    private func setupUser(id: String) {
        guard let user = service.getUser(id: id) else { return }

        self.user = user
    }
}
