//
//  SettingsScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
final class SettingsScreenWorker: SettingsScreenWorkerLogic {
    
    let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func loadUserProfileData() -> ProfileSettingsModels.ProfileUserData {
        let nickname =  userDefaultsManager.loadNickname()
        let username = userDefaultsManager.loadUsername()
        return ProfileSettingsModels.ProfileUserData(nickname: nickname, username: username)
    }
}
