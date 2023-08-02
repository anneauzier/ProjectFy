//
//  EditUserViewModel.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 01/08/23.
//

import SwiftUI

class EditUserViewModel: ObservableObject {
    @Published var oldUsername: String
    @Published var areaExpertise: String
    @Published var interests: String
    @Published var newUsername: String
    @Published var editedAreaExpertise: String
    @Published var editedInterests: String
    @Published var interestsArray: [String] = []

    init() {
        self.oldUsername = User.mock[0].name
        self.areaExpertise = User.mock[0].areaExpertise
        self.interests = "UX Designer"
        self.newUsername = ""
        self.editedInterests = ""
        self.editedAreaExpertise = ""
    }
    
    func saveChanges() {
        if newUsername != oldUsername {
            oldUsername = newUsername
        }
        if editedAreaExpertise != areaExpertise {
            areaExpertise = editedAreaExpertise
        }
        if editedInterests != interests {
            interests = editedInterests
        }
    }
    
    func cancelChanges() {
        newUsername = oldUsername
        editedAreaExpertise = editedAreaExpertise
        editedInterests = interests
    }
}
