//
//  ConfidentialityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation

// MARK: - ConfidentialityScreenWorker
final class ConfidentialityScreenWorker: ConfidentialityScreenWorkerLogic {
        
    // MARK: - Properties
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let userService: UserServiceProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol,
         userService: UserServiceProtocol, 
         keychainManager: KeychainManagerBusinessLogic
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.userService = userService
        self.keychainManager = keychainManager
    }
    
    // MARK: - User Data Getting
    func getUserData(completion: @escaping (Result<ConfidentialitySettingsModels.ConfidentialityUserData, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        userService.sendGetRestrictionRequest(accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userRestrictions):
                self.userDefaultsManager.saveRestrictions(userRestrictions.data)
                completion(.success(userRestrictions.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
