//
//  AdViewModel.swift
//  ProjectFy
//
//  Created by Iago Ramos on 03/08/23.
//

import Foundation

extension AdView {
    final class ViewModel: ObservableObject {
        @Published var owner: User?
        @Published var advertisement: Advertisement?
        
        init(advertisementID: String) {
            self.setupAdvertisement(id: advertisementID)
        }
        
        private func setupAdvertisement(id: String) {
            guard let advertisement = Advertisement.mock.first(where: { $0.id == id }) else {
                return
            }
            
            guard let user = User.mock.first(where: { $0.id == advertisement.ownerID }) else {
                return
            }
            
            owner = user
            self.advertisement = advertisement
        }
    }
    
}
