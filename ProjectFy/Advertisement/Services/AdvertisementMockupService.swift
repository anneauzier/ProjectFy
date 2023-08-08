//
//  AdvertisementMockupService.swift
//  ProjectFy
//
//  Created by Iago Ramos on 07/08/23.
//

import Foundation

final class AdvertisementMockupService: AdvertisementProtocol, ObservableObject {
    private var advertisements = [
        Advertisement(
            id: "1234",
            ownerID: "1234",
            title: "Primeiro Anuncio",
            description: "mock1",
            positions: [
                ProjectGroup.Position(
                    id: UUID().uuidString,
                    title: "Level designer",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid",
                    vacancies: 3,
                    joined: []
                ),
                ProjectGroup.Position(
                    id: UUID().uuidString,
                    title: "Designer",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid",
                    vacancies: 3,
                    joined: []
                )
            ],
            applicationsIDs: [:],
            weeklyWorkload: nil,
            ongoing: true,
            tags: ["Level Design", "Game Design", "Design"]
        )
    ]
    
    func getAdvertisements() -> [Advertisement] {
        return advertisements
    }
    
    func createAdvertisement(_ advertisement: Advertisement) {
        advertisements.append(advertisement)
    }
    
    func updateAdvertisement(_ advertisement: Advertisement) {
        guard let index = advertisements.firstIndex(where: { $0.id == advertisement.id }) else { return }
        advertisements[index] = advertisement
    }
    
    func deleteAdvertisement(by id: String) {
        guard let index = advertisements.firstIndex(where: { $0.id == id }) else { return }
        advertisements.remove(at: index)
    }
    
    func getAdvertisement(by id: String) -> Advertisement? {
        return advertisements.first(where: { $0.id == id })
    }
    
    func getAdvertisementByPosition(positionID: String) -> Advertisement? {
        return getAdvertisements().first(where: {
            $0.positions.map(\.id).contains(positionID)
        })
    }
    
    func apply(userID: String, for position: ProjectGroup.Position) {
        guard var advertisement = getAdvertisementByPosition(positionID: position.id) else { return }
        
        advertisement.applicationsIDs.updateValue(position, forKey: userID)
        updateAdvertisement(advertisement)
    }
    
    func unapply(userID: String, from position: ProjectGroup.Position) {
        guard var advertisement = getAdvertisementByPosition(positionID: position.id) else { return }
        
        advertisement.applicationsIDs.removeValue(forKey: userID)
        updateAdvertisement(advertisement)
    }
}
