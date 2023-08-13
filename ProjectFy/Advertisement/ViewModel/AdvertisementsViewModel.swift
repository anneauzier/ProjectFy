//
//  AdvertisementsViewModel.swift
//  ProjectFy
//
//  Created by Iago Ramos on 06/08/23.
//

import Foundation

final class AdvertisementsViewModel: ObservableObject {
    @Published var advertisements: [Advertisement] = []
    
    private let service: AdvertisementProtocol
    
    init(service: AdvertisementProtocol) {
        self.service = service
        
        service.getAdvertisements { [weak self] advertisements in
            guard let advertisements = advertisements else { return }
            self?.advertisements = advertisements
        }
    }
    
    func createAdvertisement(_ advertisement: Advertisement) {
        do {
            try service.create(advertisement)
        } catch {
            print("Cannot create advertisement: \(error.localizedDescription)")
        }
    }
    
    func getAdvertisement(with id: String) -> Advertisement? {
        return advertisements.first(where: { $0.id == id })
    }
    
    func editAdvertisement(_ advertisement: Advertisement) {
        do {
            try service.update(advertisement)
        } catch {
            print("Cannot update advertisement: \(error)")
        }
    }
    
    func deleteAdvertisement(with id: String) {
        service.delete(with: id)
    }
}
