//
//  ProfileSettingsModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit

// MARK: - ProfileSettingsModels
enum ProfileSettingsModels {
    struct ProfileUserData: Codable {
        let id: UUID
        let name: String
        let username: String
        let phone: String
        let photo: URL?
        let dateOfBirth: String?
    }
    
    struct Users: Codable {
        let users: [ProfileSettingsModels.ProfileUserData]
    }
    
    struct ChangeableProfileUserData: Codable {
        var name: String
        var username: String
        var photo: URL?
        var dateOfBirth: String?
    }
}
