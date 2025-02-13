//
//  UpdateRestrictionsEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 13.02.2025.
//

import Foundation

final class UpdateRestrictionsEvent: Event {
    
    var newPhone: ConfidentialityDetails
    var newDateOfBirth: ConfidentialityDetails
    
    init(newPhone: ConfidentialityDetails, newDateOfBirth: ConfidentialityDetails) {
        self.newPhone = newPhone
        self.newDateOfBirth = newDateOfBirth
    }
    
}
