//
//  UpdateAudioNotificationEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 01.02.2025.
//

import Foundation

// MARK: - UpdateAudioNotificationEvent
final class UpdateAudioNotificationEvent: Event {
    
    var newAudioNotificationStatus: Bool
    
    init(newAudioNotificationStatus: Bool) {
        self.newAudioNotificationStatus = newAudioNotificationStatus
    }
}
