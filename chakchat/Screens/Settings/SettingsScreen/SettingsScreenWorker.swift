//
//  SettingsScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation

// MARK: - SettingsScreenWorker
final class SettingsScreenWorker: SettingsScreenWorkerLogic {
    
    // MARK: - Properties
    let userDefaultsManager: UserDefaultsManagerProtocol
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    // MARK: - User Profile Data Loading
    func loadUserProfileData() -> ProfileSettingsModels.ProfileUserData {
        let nickname =  userDefaultsManager.loadNickname()
        let username = userDefaultsManager.loadUsername()
        return ProfileSettingsModels.ProfileUserData(nickname: nickname, username: username)
    }
}
