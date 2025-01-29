//
//  ConfidentialityScreenModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
enum ConfidentialitySettingsModels {
    struct ConfidentialityUserData {
        var phoneNumberState: ConfidentialityState
        var dateOfBirthState: ConfidentialityState
        var onlineStatus: ConfidentialityState
    }
}

enum ConfidentialityState: String {
    case all = "All"
    case onlyContacts = "Only contacts"
    case nobody = "Nobody"
}
