//
//  TasksMockupService.swift
//  ProjectFy
//
//  Created by Anne Victoria Batista Auzier on 16/08/23.
//

import SwiftUI

class TasksMockupService: ObservableObject {

    @Published private(set) var messages: [Tasks] = []
    @Published private(set) var lastMessageId: String = ""
    
    private let mockMessages: [Tasks] = [
        Tasks(id: "1234", senderName: "Iago Ramos",
             text: ["oi, tudo bem?", "hoje eu dei push em tal branch"],
             received: false, time: Date()),
        Tasks(id: "12345", senderName: "Anne Auzier",
             text: ["beleza mano00000000000000000000000000000000000000000000000000", "vou já dar pull00000000000000000000000000000000000000000000000000"],
             received: true, time: Date().addingTimeInterval(1000))
    ]

    init() {
        loadMockMessages()
    }
    
    func loadMockMessages() {
        messages = mockMessages.sorted { $0.time < $1.time }
        lastMessageId = messages.last?.id ?? ""
    }
    
    func sendMessage(text: String) {
        // In a real scenario, you might append a new message to mockMessages,
        // but for this example, we won't simulate adding new messages.
    }
}
