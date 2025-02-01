//
//  NicknameEvent.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit
final class UpdateProfileDataEvent: Event {
    var newNickname: String
    var newUsername: String
    var icon: UIImage?
    
    init(newNickname: String, newUsername: String, icon: UIImage? = nil) {
        self.newNickname = newNickname
        self.newUsername = newUsername
        self.icon = icon
    }
}
