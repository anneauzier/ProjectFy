//
//  AdvertisementsViewModel.swift
//  ProjectFy
//
//  Created by Iago Ramos on 06/08/23.
//

import Foundation

final class AdvertisementsViewModel: ObservableObject {
    @Published var advertisements: [Advertisement]
    
    private let service: AdvertisementProtocol
    
    init(service: AdvertisementProtocol) {
        self.service = service
        self.advertisements = service.getAdvertisements()
    }
    
    func createAdvertisement(_ advertisement: Advertisement) {
        service.createAdvertisement(advertisement)
        updateAdvertisements()
    }
    
    func getAdvertisement(by id: String) -> Advertisement? {
        return service.getAdvertisement(by: id)
    }
    
    func editAdvertisement(_ advertisement: Advertisement) {
        service.updateAdvertisement(advertisement)
        updateAdvertisements()
    }
    
    func deleteAdvertisement(by id: String) {
        service.deleteAdvertisement(by: id)
        updateAdvertisements()
    }
    
    private func updateAdvertisements() {
        advertisements = service.getAdvertisements()
    }
}
