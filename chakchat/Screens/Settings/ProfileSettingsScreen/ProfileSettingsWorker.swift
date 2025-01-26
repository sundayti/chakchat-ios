//
//  ProfileSettingsWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
final class ProfileSettingsWorker: ProfileSettingsWorkerLogic {
    
    let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func saveNewData(_ userData: ProfileSettingsModels.ProfileUserData) {
        userDefaultsManager.saveNickname(userData.nickname)
        userDefaultsManager.saveUsername(userData.username)
    }
}
