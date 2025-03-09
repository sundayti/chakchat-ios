//
//  NicknameEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import UIKit

// MARK: - UpdateProfileDataEvent
final class UpdateProfileDataEvent: Event {
    
    var newNickname: String
    var newUsername: String
    var newBirth: String?
    
    init(newNickname: String, newUsername: String, newBirth: String? = nil) {
        self.newNickname = newNickname
        self.newUsername = newUsername
        self.newBirth = newBirth
    }
}
