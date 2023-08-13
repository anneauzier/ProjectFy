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
                    id: "1234",
                    title: "Level designer",
                    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid",
                    vacancies: 3,
                    applied: [],
                    joined: []
                )
            ],
            weeklyWorkload: nil,
            ongoing: true,
            tags: ["Level Design", "Game Design", "Design"]
        )
    ]
    
    func getAdvertisements(completion: @escaping ([Advertisement]?) -> Void) {
        completion(advertisements)
    }
    
    func create(_ advertisement: Advertisement) throws {
        advertisements.append(advertisement)
    }
    
    func updateAdvertisement(_ advertisement: Advertisement) {
        guard let index = advertisements.firstIndex(where: { $0.id == advertisement.id }) else { return }
        advertisements[index] = advertisement
    }
    
    func delete(with id: String) {
        guard let index = advertisements.firstIndex(where: { $0.id == id }) else { return }
        advertisements.remove(at: index)
    }
    
    func getAdvertisement(with id: String, completion: @escaping (Advertisement?) -> Void) {
        completion(advertisements.first(where: { $0.id == id }))
    }
    
    func update(_ advertisement: Advertisement) throws {
        guard let index = advertisements.firstIndex(where: { $0.id == advertisement.id }) else {
            throw URLError(.fileDoesNotExist)
        }
        
        advertisements[index] = advertisement
    }
}
