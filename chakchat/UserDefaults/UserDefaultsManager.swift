//
//  UserDefaultsService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 22.01.2025.
//

import Foundation
import UIKit

class UserDefaultsManager: UserDefaultsManagerProtocol {

    private let avatarKey = "userAvatar"
    private let nicknameKey = "userNickname"
    private let usernameKey = "userUsername"
    private let phoneKey = "userPhone"
    
    func saveAvatar(_ icon: UIImage) {
        print("Hello world")
    }
    
    func saveNickname(_ nickname: String) {
        UserDefaults.standard.set(nickname, forKey: nicknameKey)
    }
    
    func saveUsername(_ username: String) {
        UserDefaults.standard.set(username, forKey: usernameKey)
    }
    
    func savePhone(_ phone: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
    }
    
    func loadAvatar() -> UIImage? {
        return nil
    }
    
    func loadNickname() -> String {
        guard let nickname = UserDefaults.standard.string(forKey: nicknameKey) else {
            return ""
        }
        return nickname
    }
    
    func loadUsername() -> String {
        guard let username = UserDefaults.standard.string(forKey: usernameKey) else {
            return ""
        }
        return username
    }
    
    func loadPhone() -> String {
        guard let phone = UserDefaults.standard.string(forKey: phoneKey) else {
            return ""
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
