//
//  MessagingService.swift
//  ProjectFy
//
//  Created by Iago Ramos on 22/08/23.
//

import Foundation
import FirebaseFirestore

final class MessagingService: DBCollection {
    static let shared = MessagingService()
    
    private var listener: ListenerRegistration?
    var token: String?
    
    var userID: String? {
        didSet {
            guard let userID = userID else {
                listener?.remove()
                return
            }
            
            saveFCMToken(userID: userID)
        }
    }
    
    private init() {
        super.init(collectionName: "tokens")
    }
    
    private func saveFCMToken(userID: String) {
        listener = addSnapshotListener { [weak self] (tokens: [FCMToken]?) in
            guard let token = self?.token else { return }
            
            do {
                guard var userTokens = tokens?.first(where: { $0.userID == userID }) else {
                    let tokens = FCMToken(userID: userID, tokens: [token])
                    try self?.create(tokens, with: userID)
                    
                    return
                }
                
                if !userTokens.tokens.contains(token) {
                    userTokens.tokens.append(token)
                    try self?.update(userTokens, with: userID)
                }
            } catch {
                print("Cannot save FCMToken: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteTokens() {
        guard let userID = self.userID else { return }
        self.userID = nil
        
        delete(with: userID)
    }
    
    private struct FCMToken: Hashable, Codable {
        let userID: String
        var tokens: [String]
        
        enum CodingKeys: String, CodingKey {
            case userID = "user_id"
            case tokens
        }
    }
}