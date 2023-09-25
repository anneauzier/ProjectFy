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
    @Published var shouldScroll = false
    
    private let service: AdvertisementProtocol
    
    private var shouldRefreshAdvertisements = false
    private var allAdvertisements: [Advertisement] = [] {
        didSet {
            if shouldRefreshAdvertisements || advertisements.isEmpty {
                advertisements = allAdvertisements
                shouldRefreshAdvertisements = false
            }
        }
    }
    
    init(service: AdvertisementProtocol) {
        self.service = service
        
        service.getAdvertisements { [weak self] advertisements in
            guard var advertisements = advertisements else { return }
            
            advertisements.sort(by: { $0.date > $1.date })
            self?.allAdvertisements = advertisements
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
        return allAdvertisements.first(where: { $0.id == id })
    }
    
    func getAdvertisements(from userID: String) -> [Advertisement] {
        return allAdvertisements.filter({ $0.owner.id == userID })
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
        let advertisementsIDs = allAdvertisements.filter({ $0.owner.id == userID }).map(\.id)
        
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
    
    func refreshAdvertisements() {
        shouldRefreshAdvertisements = true
    }
}

enum TransactionStatus {
    case sending
    case completed
}
