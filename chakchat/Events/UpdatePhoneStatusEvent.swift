//
//  UpdatePhoneStatusEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class UpdatePhoneStatusEvent: Event {
    var newPhoneStatus: String
    
    init(newPhoneStatus: String) {
        self.newPhoneStatus = newPhoneStatus
    }
}
