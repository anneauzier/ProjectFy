//
//  AdvertisementProtocol.swift
//  ProjectFy
//
//  Created by Iago Ramos on 07/08/23.
//

import Foundation

protocol AdvertisementProtocol {
    
    func create(_ advertisement: Advertisement) throws
    func getAdvertisements(completion: @escaping ([Advertisement]?) -> Void)
    func update(_ advertisement: Advertisement) throws
    func delete(with id: String)

    func apply(user: User,
               to advertisement: Advertisement,
               for position: ProjectGroup.Position,
               completion: @escaping () -> Void)
    
    func unapply(user: User,
                 of advertisement: Advertisement,
                 from position: ProjectGroup.Position,
                 completion: @escaping () -> Void)
}
