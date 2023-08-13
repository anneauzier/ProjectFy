//
//  AdvertisementService.swift
//  ProjectFy
//
//  Created by Iago Ramos on 11/08/23.
//

import Foundation

final class AdvertisementService: DBCollection, AdvertisementProtocol {
    
    init() {
        super.init(collectionName: "advertisements")
    }
    
    func create(_ advertisement: Advertisement) throws {
        try create(advertisement, with: advertisement.id)
    }
    
    func update(_ advertisement: Advertisement) throws {
        try update(advertisement, with: advertisement.id)
    }
    
    func getAdvertisements(completion: @escaping ([Advertisement]?) -> Void) {
        addSnapshotListener { (advertisement: [Advertisement]?) in
            completion(advertisement)
        }
    }
}
