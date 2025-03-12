//
//  BlockedChatEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.03.2025.
//

import Foundation

class BlockedChatEvent: Event {
    let blocked: Bool
    init(blocked: Bool) {
        self.blocked = blocked
    }
}
