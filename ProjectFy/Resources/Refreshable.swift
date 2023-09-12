//
//  Refreshable.swift
//  ProjectFy
//
//  Created by Iago Ramos on 12/09/23.
//

import Foundation

class Refreshable<T, Content>: ObservableObject {
    private let observe: T
    private let keyPath: KeyPath<T, Content>
    
    private var content: Content
    
    init(observe: T, keyPath: KeyPath<T, Content>) {
        self.observe = observe
        self.keyPath = keyPath
        
        self.content = observe[keyPath: keyPath]
    }
    
    func refresh() {
        content = observe[keyPath: keyPath]
        objectWillChange.send()
    }
    
    subscript() -> Content {
        get {
            content
        }
    }
}
