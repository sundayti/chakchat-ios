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
    private let confidentialityPhoneKey = "confidentialityPhone"
    private let confidentialityBirthKey = "confidentialityBirth"
    private let confidentialityOnlineKey = "confidentialityOnline"
    private let generalNotificationKey = "generalNotification"
    private let audioNotificationKey = "audioNotification"
    private let vibrationNotificationKey = "vibrationNotification"
    
    // MARK: - Avatar Saving
    func saveAvatar(_ icon: UIImage?) {
        if let icon = icon?.pngData() {
            UserDefaults.standard.set(icon, forKey: avatarKey)
        }
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
    
    func loadAvatar() -> UIImage? {
        if let data = UserDefaults.standard.data(forKey: avatarKey) {
            let image = UIImage(data: data)
            return image
        }
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
    
    func loadBirth() -> String? {
        if let birth = UserDefaults.standard.string(forKey: birthKey) {
            return birth
        }
        return nil
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
