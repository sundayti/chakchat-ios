//
//  DeletedChatEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.03.2025.
//

import Foundation

class DeletedChatEvent: Event {
    
    let chatID: UUID
    
    init(chatID: UUID) {
        self.chatID = chatID
    }
}
