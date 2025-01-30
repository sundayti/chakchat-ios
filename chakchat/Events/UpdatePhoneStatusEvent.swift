//
//  UpdatePhoneStatusEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class UpdatePhoneStatusEvent: Event {
    var newPhoneStatus: ConfidentialityState
    
    init(newPhoneStatus: ConfidentialityState) {
        self.newPhoneStatus = newPhoneStatus
    }
}
