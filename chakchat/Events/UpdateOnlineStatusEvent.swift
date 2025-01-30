//
//  UpdateOnlineStatusEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class UpdateOnlineStatusEvent: Event {
    var newOnlineStatus: String
    
    init(newOnlineStatus: String) {
        self.newOnlineStatus = newOnlineStatus
    }
}
