//
//  UpdatePhoneStatusEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - UpdatePhoneStatusEvent
final class UpdatePhoneStatusEvent: Event {
    
    // MARK: - Properties
    var newPhoneStatus: ConfidentialityState
    
    // MARK: - Initialization
    init(newPhoneStatus: ConfidentialityState) {
        self.newPhoneStatus = newPhoneStatus
    }
}
