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
    private let birthKey = "birthKey"
    private let onlineKey = "onlineKey"
    private let restrictionsKey = "restrictionsKey"
    private let generalNotificationKey = "generalNotification"
    private let audioNotificationKey = "audioNotification"
    private let vibrationNotificationKey = "vibrationNotification"
    
    func saveUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        saveNickname(userData.nickname)
        saveUsername(userData.username)
        savePhone(userData.phone)
        saveBirth(userData.dateOfBirth)
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
    
    func saveBirth(_ birth: String?) {
        UserDefaults.standard.set(birth, forKey: birthKey)
    }
    
    func saveOnlineStatus(_ online: String) {
        UserDefaults.standard.set(online, forKey: onlineKey)
    }
    
    func saveRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userRestrictions) {
            UserDefaults.standard.set(encoded, forKey: restrictionsKey)
        }
    }
    
    func saveGeneralNotificationStatus(_ generalNotificationStatus: Bool) {
        UserDefaults.standard.set(generalNotificationStatus, forKey: generalNotificationKey)
        print("General notification status = \(generalNotificationStatus)")
    }
    
    func saveAudioNotificationStatus(_ audioNotificationStatus: Bool) {
        UserDefaults.standard.set(audioNotificationStatus, forKey: audioNotificationKey)
        print("Audio notification status = \(audioNotificationStatus)")
    }
    
    func saveVibrationNotificationStatus(_ vibrationNotificationStatus: Bool) {
        UserDefaults.standard.set(vibrationNotificationStatus, forKey: vibrationNotificationKey)
        print("Vibration notification status = \(vibrationNotificationStatus)")
    }
    
    func loadUserData() -> ProfileSettingsModels.ProfileUserData {
        let nickname = loadNickname()
        let username = loadUsername()
        let phone = loadPhone()
        let dateOfBirth = loadBirth()
        return ProfileSettingsModels.ProfileUserData(id: UUID(),
                                                     nickname: nickname,
                                                     username: username,
                                                     phone: phone,
                                                     photo: nil,
                                                     dateOfBirth: dateOfBirth
        )
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
    
    func loadBirth() -> String? {
        if let birth = UserDefaults.standard.string(forKey: birthKey) {
            return birth
        }
        return nil
    }
    
    func loadOnlineStatus() -> String {
        if let online = UserDefaults.standard.string(forKey: onlineKey) {
            return online
        }
        return "everyone"
    }
    
    func loadRestrictions() -> ConfidentialitySettingsModels.ConfidentialityUserData {
        if let savedData = UserDefaults.standard.data(forKey: restrictionsKey) {
            let decoder = JSONDecoder()
            if let savedRestrictions = try? decoder.decode(ConfidentialitySettingsModels.ConfidentialityUserData.self, 
                                                           from: savedData) {
                return savedRestrictions
            }
        }
        return ConfidentialitySettingsModels.ConfidentialityUserData(phone: ConfidentialityDetails(openTo: "everyone", specifiedUsers: nil), dateOfBirth: ConfidentialityDetails(openTo: "everyone", specifiedUsers: nil))
    }
    
    func loadGeneralNotificationStatus() -> Bool {
        let generalNotificationStatus = UserDefaults.standard.bool(forKey: generalNotificationKey)
        print("General notification status is \(generalNotificationStatus)")
        return generalNotificationStatus
    }
    
    func loadAudioNotificationStatus() -> Bool {
        let audioNotificationStatus = UserDefaults.standard.bool(forKey: audioNotificationKey)
        print("Audio notification status is \(audioNotificationStatus)")
        return audioNotificationStatus
    }
    
    func loadVibrationNotificationStatus() -> Bool {
        let vibrationNotificationStatus = UserDefaults.standard.bool(forKey: vibrationNotificationKey)
        print("Vibration notification status is \(vibrationNotificationStatus)")
        return vibrationNotificationStatus
    }

    // MARK: - Avatar Deleting
    func deleteAvatar() {
        UserDefaults.standard.removeObject(forKey: avatarKey)
    }
    
    func deleteBirth() {
        UserDefaults.standard.removeObject(forKey: birthKey)
    }
}

// MARK: - UserDefaultsError
enum UserDefaultsError: Error {
    case loadError
}
