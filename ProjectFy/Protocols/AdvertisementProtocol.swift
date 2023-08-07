//
//  AdvertisementProtocol.swift
//  ProjectFy
//
//  Created by Iago Ramos on 07/08/23.
//

import Foundation

protocol AdvertisementProtocol {
    func getAdvertisements() -> [Advertisement]
    func createAdvertisement(_ advertisement: Advertisement)
    func updateAdvertisement(_ advertisement: Advertisement)
    func deleteAdvertisement(by id: String)
    
    func getAdvertisement(by id: String) -> Advertisement?
}
