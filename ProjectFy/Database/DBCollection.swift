//
//  DBCollection.swift
//  ProjectFy
//
//  Created by Iago Ramos on 11/08/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

fileprivate class DatabaseManager {
    static let shared = DatabaseManager()
    let database = Firestore.firestore()
    
    private init() {
        setSettings()
    }
    
    private func setSettings() {
        let settings = FirestoreSettings()
        settings.cacheSettings = PersistentCacheSettings(sizeBytes: 100 * 1024 * 1024 as NSNumber)
        
        database.settings = settings
    }
}

class DBCollection {
    private let database = DatabaseManager.shared.database
    private let collection: CollectionReference
    
    init(collectionName: String) {
        self.collection = self.database.collection(collectionName)
    }
    
    private func document(with id: String) -> DocumentReference {
        return collection.document(id)
    }
    
    func create(_ data: Encodable, with id: String) throws {
        try document(with: id).setData(from: data)
    }
    
    func addSnapshotListener<T: Decodable>(completion: @escaping ([T]?) -> Void) {
        
        collection.addSnapshotListener { snapshot, error in
            if let error = error {
                print("Cannot get \(T.self): \(error)")
                completion(nil)
                
                return
            }
            
            var documents: [T] = []
            
            guard let snapshot = snapshot else {
                print("Cannot get \(T.self)")
                completion(nil)
                
                return
            }
            
            for document in snapshot.documents {
                do {
                    documents.append(try document.data(as: T.self))
                } catch {
                    print("Cannot decode \(document.description) from firestore")
                }
            }
            
            completion(documents)
        }
    }
    
    func update(_ data: Encodable, with id: String) throws {
        try document(with: id).setData(from: data, merge: true)
    }
    
    func update(fields: [AnyHashable: Any], with id: String) {
        document(with: id).updateData(fields)
    }
    
    func delete(with id: String) {
        document(with: id).delete()
    }
    
    func delete(_ field: String, from id: String) {
        document(with: id).updateData([field: FieldValue.delete()])
    }
}