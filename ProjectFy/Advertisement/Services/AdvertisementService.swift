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
    
    func apply(user: User,
               to advertisement: Advertisement,
               for position: ProjectGroup.Position,
               completion: @escaping () -> Void) {
        
        runTransaction(on: advertisement.id) {
            var advertisement = advertisement
            
            let newApplication = Advertisement.Application(id: UUID().uuidString,
                                                           position: position,
                                                           user: user)
            
            advertisement.applications.append(newApplication)
            return advertisement
        } completion: {
            completion()
        }
    }
    
    func unapply(user: User,
                 of advertisement: Advertisement,
                 from position: ProjectGroup.Position,
                 completion: @escaping () -> Void) {
        
        runTransaction(on: advertisement.id) {
            var advertisement = advertisement
            advertisement.applications.removeAll(where: { $0.user.id == user.id })
            
            return advertisement
        } completion: {
            completion()
        }
    }
}
