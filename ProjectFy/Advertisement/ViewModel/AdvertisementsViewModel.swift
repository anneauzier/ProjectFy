//
//  AdvertisementsViewModel.swift
//  ProjectFy
//
//  Created by Iago Ramos on 06/08/23.
//

import Foundation

final class AdvertisementsViewModel: ObservableObject {

    @Published var advertisements: [Advertisement] = []
    @Published var applicationStatus: TransactionStatus?
    
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
    
    func getAdvertisements(from userID: String) -> [Advertisement] {
        return advertisements.filter({ $0.owner.id == userID })
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
    
    func deleteAllAdvertisements(from userID: String) {
        let advertisementsIDs = advertisements.filter({ $0.owner.id == userID }).map(\.id)
        
        advertisementsIDs.forEach { [weak self] id in
            self?.deleteAdvertisement(with: id)
        }
    }
    
    func apply(user: User, to advertisement: Advertisement, for position: ProjectGroup.Position) {
        service.apply(user: user, to: advertisement, for: position) { [weak self] in
            self?.completeApplication()
        }
    }
    
    func unapply(user: User, of advertisement: Advertisement, from position: ProjectGroup.Position) {
        service.unapply(user: user, of: advertisement, from: position) { [weak self] in
            self?.completeApplication()
        }
    }
    
    private func completeApplication() {
        DispatchQueue.main.async {
            self.applicationStatus = .completed
        }
    }
}

enum TransactionStatus {
    case sending
    case completed
}
