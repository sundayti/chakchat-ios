//
//  UserDefaultsService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 22.01.2025.
//

import Foundation
import UIKit

// MARK: - UserDefaultsManager
final class UserDefaultsManager: UserDefaultsManagerProtocol {

    // MARK: - Constants
    private let avatarKey = "userAvatar"
    private let nicknameKey = "userNickname"
    private let usernameKey = "userUsername"
    private let phoneKey = "userPhone"
    private let confidentialityPhoneKey = "confidentialityPhone"
    private let confidentialityBirthKey = "confidentialityBirth"
    private let confidentialityOnlineKey = "confidentialityOnline"
    
    // MARK: - Avatar Saving
    func saveAvatar(_ icon: UIImage) {
        print("Hello world")
    }
    
    // MARK: - Nickname Saving
    func saveNickname(_ nickname: String) {
        UserDefaults.standard.set(nickname, forKey: nicknameKey)
    }
    
    // MARK: - Username Saving
    func saveUsername(_ username: String) {
        UserDefaults.standard.set(username, forKey: usernameKey)
    }
    
    // MARK: - Phone Saving
    func savePhone(_ phone: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
    }
    
    // MARK: - Confidentiality Phone Status Saving
    func saveConfidentialityPhoneStatus(_ phoneStatus: String) {
        UserDefaults.standard.set(phoneStatus, forKey: confidentialityPhoneKey)
    }
    
    // MARK: - Confidentiality Date Of Birth Status Saving
    func saveConfidentialityDateOfBirthStatus(_ birthStatus: String) {
        UserDefaults.standard.set(birthStatus, forKey: confidentialityBirthKey)
    }
    
    // MARK: - Confidentiality Online Status Saving
    func saveConfidentialityOnlineStatus(_ onlineStatus: String) {
        UserDefaults.standard.set(onlineStatus, forKey: confidentialityOnlineKey)
    }
    
    // MARK: - Avatar Loading
    func loadAvatar() -> UIImage? {
        return nil
    }
    
    // MARK: - Nickname Loading
    func loadNickname() -> String {
        guard let nickname = UserDefaults.standard.string(forKey: nicknameKey) else {
            return "Default"
        }
        return nickname
    }
    
    // MARK: - Username Loading
    func loadUsername() -> String {
        guard let username = UserDefaults.standard.string(forKey: usernameKey) else {
            return "Default"
        }
        return username
    }
    
    // MARK: - Phone Loading
    func loadPhone() -> String {
        guard let phone = UserDefaults.standard.string(forKey: phoneKey) else {
            return "Default"
        }
        return phone
    }
    
    // MARK: - Confidentiality Phone Status Loading
    func loadConfidentialityPhoneStatus() -> String {
        guard let phoneStatus = UserDefaults.standard.string(forKey: confidentialityPhoneKey) else {
            return "All"
        }
        return phoneStatus
    }
    
    // MARK: - Confidentiality Date Of Birth Status Loading
    func loadConfidentialityDateOfBirthStatus() -> String {
        guard let dateOfBirthStatus = UserDefaults.standard.string(forKey: confidentialityBirthKey) else {
            return "All"
        }
        return dateOfBirthStatus
    }
    
    // MARK: - Confidentiality Online Status Loading
    func loadConfidentialityOnlineStatus() -> String {
        guard let onlineStatus = UserDefaults.standard.string(forKey: confidentialityOnlineKey) else {
            return "All"
        }
        return onlineStatus
    }

    // MARK: - Avatar Deleting
    func deleteAvatar() {
        UserDefaults.standard.removeObject(forKey: avatarKey)
    }
}

// MARK: - UserDefaultsError
enum UserDefaultsError: Error {
    case loadError
}
