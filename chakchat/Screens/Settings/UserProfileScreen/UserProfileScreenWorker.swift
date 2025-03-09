//
//  UserProfileScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//

import Foundation

// MARK: - UserProfileScreenWorker
final class UserProfileScreenWorker: UserProfileScreenWorkerLogic {
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol) {
        self.userDefaultsManager = userDefaultsManager
    }
    
    // MARK: - Public Methods
    func getUserData() -> ProfileSettingsModels.ProfileUserData {
        return userDefaultsManager.loadUserData()
    }
}
