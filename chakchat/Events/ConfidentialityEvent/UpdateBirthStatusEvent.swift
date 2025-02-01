//
//  UpdateBirthStatusEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - UpdateBirthStatusEvent
final class UpdateBirthStatusEvent: Event {
    
    // MARK: - Properties
    var newBirthStatus: ConfidentialityState
    
    // MARK: - Initialization
    init(newBirthStatus: ConfidentialityState) {
        self.newBirthStatus = newBirthStatus
    }
}
