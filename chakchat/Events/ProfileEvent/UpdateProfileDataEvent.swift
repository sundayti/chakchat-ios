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
    var newIcon: UIImage?
    
    // MARK: - Initialization
    init(newNickname: String, newUsername: String, newIcon: UIImage? = nil) {
        self.newNickname = newNickname
        self.newUsername = newUsername
        self.newIcon = newIcon
    }
}
