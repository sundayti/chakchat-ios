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
    struct ProfileUserData {
        var id: UUID
        var nickname: String
        var username: String
        let phone: String
        var photo: UIImage?
        var dateOfBirth: String?
    }
}
