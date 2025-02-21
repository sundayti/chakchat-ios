//
//  BirthVisibilityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - BirthVisibilityScreenWorker
final class BirthVisibilityScreenWorker: BirthVisibilityScreenWorkerLogic {
    
    // MARK: - Properties
    private let userDeafultsManager: UserDefaultsManagerProtocol
    private let userService: UserServiceProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    
    // MARK: - Initialization
    init(userDeafultsManager: UserDefaultsManagerProtocol, 
         userService: UserServiceProtocol,
         keychainManager: KeychainManagerBusinessLogic
    ) {
        self.userDeafultsManager = userDeafultsManager
        self.userService = userService
        self.keychainManager = keychainManager
    }
    
    func updateUserRestriction(_ request: ConfidentialitySettingsModels.ConfidentialityUserData, completion: @escaping (Result<Void, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        userService.sendPutRestrictionRequest(request, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.userDeafultsManager.saveRestrictions(request)
                completion(.success(()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func saveNewRestrictions(_ newUserRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        userDeafultsManager.saveRestrictions(newUserRestrictions)
    }
}
