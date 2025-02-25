//
//  NicknameEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import UIKit

// MARK: - UpdateProfileDataEvent
final class UpdateProfileDataEvent: Event {
    
    // MARK: - Properties
    var newNickname: String
    var newUsername: String
    var newBirth: String?
    
    // MARK: - Initialization
    init(newNickname: String, newUsername: String, newBirth: String? = nil) {
        self.newNickname = newNickname
        self.newUsername = newUsername
        self.newBirth = newBirth
    }
}
