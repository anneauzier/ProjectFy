//
//  AdvertisementMockupService.swift
//  ProjectFy
//
//  Created by Iago Ramos on 07/08/23.
//

import Foundation

final class AdvertisementMockupService: AdvertisementProtocol, ObservableObject {
    func getAdvertisements() -> [Advertisement] {
        return Advertisement.mock
    }
    
    func createAdvertisement(_ advertisement: Advertisement) {
        Advertisement.mock.append(advertisement)
    }
    
    func updateAdvertisement(_ advertisement: Advertisement) {
        guard let index = Advertisement.mock.firstIndex(where: { $0.id == advertisement.id }) else { return }
        Advertisement.mock[index] = advertisement
    }
    
    func deleteAdvertisement(by id: String) {
        guard let index = Advertisement.mock.firstIndex(where: { $0.id == id }) else { return }
        Advertisement.mock.remove(at: index)
    }
    
    func getAdvertisement(by id: String) -> Advertisement? {
        return Advertisement.mock.first(where: { $0.id == id })
    }
}
