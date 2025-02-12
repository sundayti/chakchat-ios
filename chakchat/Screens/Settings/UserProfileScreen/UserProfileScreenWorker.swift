//
//  UserProfileScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//

import Foundation

final class UserProfileScreenWorker: UserProfileScreenWorkerLogic {
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    func getUserData() -> ProfileSettingsModels.ProfileUserData {
        return userDefaultsManager.loadUserData()
    }
}
