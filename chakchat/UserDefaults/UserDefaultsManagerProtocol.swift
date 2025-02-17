//
//  UserDefaultsManagerProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit

// MARK: - UserDefaultsManagerProtocol
protocol UserDefaultsManagerProtocol {
    
    func saveUserData(_ userData: ProfileSettingsModels.ProfileUserData)
    func saveNickname(_ nickname: String)
    func saveUsername(_ username: String)
    func savePhone(_ phone: String)
    func saveBirth(_ birth: String?)
    func saveOnlineStatus(_ online: String)
    func saveRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData)
    func saveGeneralNotificationStatus(_ generalNotificationStatus: Bool)
    func saveAudioNotificationStatus(_ audioNotificationStatus: Bool)
    func saveVibrationNotificationStatus(_ visualNotificationStatus: Bool)
    
    func savePhotoPath(_ path: String)
    func savePhotoMetadata(_ photo: SuccessModels.UploadResponse)
    
    func loadUserData() -> ProfileSettingsModels.ProfileUserData
    func loadNickname() -> String
    func loadUsername() -> String
    func loadPhone() -> String
    func loadBirth() -> String?
    func loadOnlineStatus() -> String
    func loadRestrictions() -> ConfidentialitySettingsModels.ConfidentialityUserData
    func loadGeneralNotificationStatus() -> Bool
    func loadAudioNotificationStatus() -> Bool
    func loadVibrationNotificationStatus() -> Bool
    
    func loadPhotoPath() -> String?
    func loadPhotoMetadata() -> SuccessModels.UploadResponse?
    
    func deleteBirth()
    func deletePhotoPath()
}
