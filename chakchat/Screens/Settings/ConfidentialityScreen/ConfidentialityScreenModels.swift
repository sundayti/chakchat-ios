//
//  ConfidentialityScreenModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation

// MARK: - ConfidentialitySettingsModels
enum ConfidentialitySettingsModels {
    struct ConfidentialityUserData: Codable {
        let phone: ConfidentialityDetails
        let dateOfBirth: ConfidentialityDetails
    }
}

struct ConfidentialityDetails: Codable {
    let openTo: String // everyone, only_me, specified
    let specifiedUsers: [UUID]?
    
    enum CodingKeys: String, CodingKey {
        case openTo = "open_to"
        case specifiedUsers = "specified_users"
    }
}
    
