//
//  UpdateOnlineStatusEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - UpdateOnlineStatusEvent
final class UpdateOnlineStatusEvent: Event {
    
    // MARK: - Properties
    var newOnlineStatus: ConfidentialityState
    
    // MARK: - Initialization
    init(newOnlineStatus: ConfidentialityState) {
        self.newOnlineStatus = newOnlineStatus
    }
}
