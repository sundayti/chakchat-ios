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
        var phone: ConfidentialityDetails
        var dateOfBirth: ConfidentialityDetails
    }
}

// MARK: - ConfidentialityState
struct ConfidentialityDetails: Codable {
    var openTo: String // everyone, only_me, specified
    var specifiedUsers: [UUID]?
    
    enum CodingKeys: String, CodingKey {
        case openTo = "open_to"
        case specifiedUsers = "specified_users"
    }
}
