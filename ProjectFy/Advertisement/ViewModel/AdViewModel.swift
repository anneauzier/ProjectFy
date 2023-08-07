//
//  AdViewModel.swift
//  ProjectFy
//
//  Created by Iago Ramos on 03/08/23.
//

import Foundation

final class AdViewModel: ObservableObject {
    @Published var owner: User?
    @Published var advertisement: Advertisement?
    
    private let service: AdvertisementProtocol
    
    init(service: AdvertisementProtocol, advertisementID: String) {
        self.service = service
        self.setupAdvertisement(id: advertisementID)
    }
    
    private func setupAdvertisement(id: String) {
        guard let advertisement = service.getAdvertisement(by: id) else { return }
        
        guard let user = User.mock.first(where: { $0.id == advertisement.ownerID }) else {
            return
        }
        
        owner = user
        self.advertisement = advertisement
    }
}
