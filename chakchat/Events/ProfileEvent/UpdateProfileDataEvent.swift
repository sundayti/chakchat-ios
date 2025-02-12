//
//  NicknameEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit

// MARK: - UpdateProfileDataEvent
final class UpdateProfileDataEvent: Event {
    
    // MARK: - Properties
    var newNickname: String
    var newUsername: String
    var newPhoto: UUID?
    var newBirth: String?
    
    // MARK: - Initialization
    init(newNickname: String, newUsername: String, newPhoto: UUID? = nil, newBirth: String? = nil) {
        self.newNickname = newNickname
        self.newUsername = newUsername
        self.newPhoto = newPhoto
        self.newBirth = newBirth
    }
}
