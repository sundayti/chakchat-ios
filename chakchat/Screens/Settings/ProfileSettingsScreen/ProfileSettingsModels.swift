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
        var id: UUID
        var name: String
        var username: String
        let phone: String
        var photo: URL?
        var dateOfBirth: String?
    }
    
    struct ChangeableProfileUserData {
        var name: String
        var username: String
        var photo: URL?
        var dateOfBirth: String?
    }
}
