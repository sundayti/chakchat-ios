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
    private let confidentialityPhoneKey = "confidentialityPhone"
    private let confidentialityBirthKey = "confidentialityBirth"
    private let confidentialityOnlineKey = "confidentialityOnline"
    private let generalNotificationKey = "generalNotification"
    private let audioNotificationKey = "audioNotification"
    private let vibrationNotificationKey = "vibrationNotification"
    
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
    
    func saveConfidentialityPhoneStatus(_ phoneStatus: String) {
        UserDefaults.standard.set(phoneStatus, forKey: confidentialityPhoneKey)
    }
    
    func saveConfidentialityDateOfBirthStatus(_ birthStatus: String) {
        UserDefaults.standard.set(birthStatus, forKey: confidentialityBirthKey)
    }
    
    func saveConfidentialityOnlineStatus(_ onlineStatus: String) {
        UserDefaults.standard.set(onlineStatus, forKey: confidentialityOnlineKey)
    }
    
    func saveGeneralNotificationStatus(_ generalNotificationStatus: Bool) {
        UserDefaults.standard.set(generalNotificationStatus, forKey: generalNotificationKey)
    }
    
    func saveAudioNotificationStatus(_ audioNotificationStatus: Bool) {
        UserDefaults.standard.set(audioNotificationStatus, forKey: audioNotificationKey)
    }
    
    func saveVibrationNotificationStatus(_ visualNotificationStatus: Bool) {
        UserDefaults.standard.set(visualNotificationStatus, forKey: vibrationNotificationKey)
    }
    
    func loadAvatar() -> UIImage? {
        return nil
    }
    
    func loadNickname() -> String {
        guard let nickname = UserDefaults.standard.string(forKey: nicknameKey) else {
            return "Default"
        }
        return nickname
    }
    
    func loadUsername() -> String {
        guard let username = UserDefaults.standard.string(forKey: usernameKey) else {
            return "Default"
        }
        return username
    }
    
    func loadPhone() -> String {
        guard let phone = UserDefaults.standard.string(forKey: phoneKey) else {
            return "Default"
        }
        return phone
    }
    
    func loadConfidentialityPhoneStatus() -> String {
        guard let phoneStatus = UserDefaults.standard.string(forKey: confidentialityPhoneKey) else {
            return "All"
        }
        return phoneStatus
    }
    
    func loadConfidentialityDateOfBirthStatus() -> String {
        guard let dateOfBirthStatus = UserDefaults.standard.string(forKey: confidentialityBirthKey) else {
            return "All"
        }
        return dateOfBirthStatus
    }
    
    func loadConfidentialityOnlineStatus() -> String {
        guard let onlineStatus = UserDefaults.standard.string(forKey: confidentialityOnlineKey) else {
            return "All"
        }
        return onlineStatus
    }
    
    func loadGeneralNotificationStatus() -> Bool {
        let generalNotificationStatus = UserDefaults.standard.bool(forKey: generalNotificationKey)
        return generalNotificationStatus
    }
    
    func loadAudioNotificationStatus() -> Bool {
        let audioNotificationStatus = UserDefaults.standard.bool(forKey: audioNotificationKey)
        return audioNotificationStatus
    }
    
    func loadVibrationNotificationStatus() -> Bool {
        let visualNotificationStatus = UserDefaults.standard.bool(forKey: vibrationNotificationKey)
        return visualNotificationStatus
    }

    func deleteAvatar() {
        UserDefaults.standard.removeObject(forKey: avatarKey)
    }
}

enum UserDefaultsError: Error {
    case loadError
}
