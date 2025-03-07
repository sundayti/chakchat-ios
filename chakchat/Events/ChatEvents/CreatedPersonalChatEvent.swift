//
//  CreatedPersonalChatEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.03.2025.
//

import Foundation

final class CreatedPersonalChatEvent: Event {
    let chatID: UUID
    let members: [UUID]
    let blocked: Bool
    let blockedBy: [UUID]?
    let createdAt: Date
    
    init(chatID: UUID, members: [UUID], blocked: Bool, blockedBy: [UUID]?, createdAt: Date) {
        self.chatID = chatID
        self.members = members
        self.blocked = blocked
        self.blockedBy = blockedBy
        self.createdAt = createdAt
    }
}
