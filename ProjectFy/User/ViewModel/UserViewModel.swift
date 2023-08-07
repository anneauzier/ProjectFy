//
//  UserViewModel.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

class UserViewModel: ObservableObject {

    @Published var user: User
    @Published var availability: String

    init(user: User) {
        self.user = user
        self.availability = "Disponível"
    }

    func saveChanges(editedUser: User) {
        guard !editedUser.name.isEmpty && !editedUser.areaExpertise.isEmpty &&
                !editedUser.interestTags.isEmpty && !editedUser.region.isEmpty else { return }
        user = editedUser

        guard let index = User.mock.firstIndex(where: { $0.id == user.id }) else { return }
        User.mock[index] = user
        
        availability = user.available ? "Disponível" : "Indisponível"
    }

//    private func setupUser(id: String) {
//        guard let user = User.mock.first(where: {$0.id == id}) else { return }
//    }

}
