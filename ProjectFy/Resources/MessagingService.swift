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
    
    var token: String? {
        didSet {
            setupFCMToken()
        }
    }
    
    var userID: String? {
        didSet {
            setupFCMToken()
        }
    }
    
    private init() {
        super.init(collectionName: "tokens")
    }
    
    private func setupFCMToken() {
        guard let userID = userID, let token = token else {
            listener?.remove()
            return
        }
        
        saveFCMToken(userID: userID, token: token)
    }
    
    private func saveFCMToken(userID: String, token: String) {
        listener = addSnapshotListener { [weak self] (tokens: [FCMToken]?) in
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
