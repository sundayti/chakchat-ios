//
//  UserDefaultsService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 22.01.2025.
//

import Foundation
import UIKit

class UserDefaultsManager {
    private let avatarKey = "userAvatar"
    private let nicknameKey = "userNickname"
    private let usernameKey = "userUsername"
    private let phoneKey = "userPhone"

    func saveAvatar(image: UIImage, compressionQuality: CGFloat = 0.8) -> Bool {
        guard let imageData = image.jpegData(compressionQuality: compressionQuality) else {
            print("Error: can't save the icon")
            return false
        }
        UserDefaults.standard.set(imageData, forKey: avatarKey)
        return true
    }
    
    func saveInitials(nickname: String, username: String) {
        UserDefaults.standard.set(nickname, forKey: nicknameKey)
        UserDefaults.standard.set(username, forKey: usernameKey)
    }
    
    func savePhone(phone: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
    }

    func loadAvatar() -> UIImage? {
        guard let imageData = UserDefaults.standard.data(forKey: avatarKey) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    
    func loadNickname() -> String? {
        guard let nickname = UserDefaults.standard.string(forKey: nicknameKey) else {
            print("Can't find nickname in user defaults")
            return nil
        }
        return nickname
    }
    
    func loadUsername() -> String? {
        guard let username = UserDefaults.standard.string(forKey: usernameKey) else {
            print("Can't find username in user defaults")
            return nil
        }
        return username
    }
    
    func loadPhone() -> String? {
        guard let phone = UserDefaults.standard.string(forKey: phoneKey) else {
            print("Can't find phone in user defaults")
            return nil
        }
        return phone
    }

    func deleteAvatar() {
        UserDefaults.standard.removeObject(forKey: avatarKey)
    }
}

enum UserDefaultsError: Error {
    case loadError
}
