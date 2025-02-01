//
//  UpdateOnlineStatusEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class UpdateOnlineStatusEvent: Event {
    var newOnlineStatus: ConfidentialityState
    
    init(newOnlineStatus: ConfidentialityState) {
        self.newOnlineStatus = newOnlineStatus
    }
}
