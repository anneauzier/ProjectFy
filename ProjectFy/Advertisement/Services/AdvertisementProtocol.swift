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

//    func apply(userID: String, for position: ProjectGroup.Position)
//    func unapply(userID: String, from position: ProjectGroup.Position)
}
