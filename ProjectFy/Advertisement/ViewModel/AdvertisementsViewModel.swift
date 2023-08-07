//
//  AdvertisementsViewModel.swift
//  ProjectFy
//
//  Created by Iago Ramos on 06/08/23.
//

import Foundation

extension AdvertisementView {
    class ViewModel: ObservableObject {
        @Published var advertisements: [Advertisement] = Advertisement.mock
        
        func createAdvertisement(_ advertisement: Advertisement) {
            Advertisement.mock.append(advertisement)
            advertisements = Advertisement.mock
        }
        
        func getAdvertisement(by id: String) -> Advertisement? {
            return advertisements.first(where: { $0.id == id })
        }
        
        func editAdvertisement(_ advertisement: Advertisement) {
            guard let index = Advertisement.mock.firstIndex(where: { $0.id == advertisement.id }) else { return }
            
            Advertisement.mock[index] = advertisement
            self.advertisements = Advertisement.mock
        }
        
        func deleteAdvertisement(by id: String) {
            guard let index = Advertisement.mock.firstIndex(where: { $0.id == id }) else { return }
            
            Advertisement.mock.remove(at: index)
            self.advertisements = Advertisement.mock
        }
    }
}
