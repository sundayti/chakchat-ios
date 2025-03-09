//
//  UpdateVibrationNotificationEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 01.02.2025.
//

import Foundation

// MARK: - UpdateVibrationNotificationEvent
final class UpdateVibrationNotificationEvent: Event {
    
    var newVibrationNotificationStatus: Bool
    
    init(newVibrationNotificationStatus: Bool) {
        self.newVibrationNotificationStatus = newVibrationNotificationStatus
    }
}
