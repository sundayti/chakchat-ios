//
//  UpdateBirthStatusEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class UpdateBirthStatusEvent: Event {
    var newBirthStatus: String
    
    init(newBirthStatus: String) {
        self.newBirthStatus = newBirthStatus
    }
}
