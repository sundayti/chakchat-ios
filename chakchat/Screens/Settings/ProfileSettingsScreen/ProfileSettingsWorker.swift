//
//  ProfileSettingsWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation

// MARK: - ProfileSettingsWorker
final class ProfileSettingsWorker: ProfileSettingsWorkerLogic {
    
    // MARK: - Properties
    let userDefaultsManager: UserDefaultsManagerProtocol
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    // MARK: - New Data Saving
    func saveNewData(_ userData: ProfileSettingsModels.ProfileUserData) {
        userDefaultsManager.saveNickname(userData.nickname)
        userDefaultsManager.saveUsername(userData.username)
        if let data = userData.dateOfBirth {
            userDefaultsManager.saveBirth(data)
        } else {
            userDefaultsManager.saveBirth(nil)
        }
    }
}
