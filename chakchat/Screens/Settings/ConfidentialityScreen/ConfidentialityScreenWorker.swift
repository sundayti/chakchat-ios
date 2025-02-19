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
    private let meService: UserServiceProtocol
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol,
         meService: UserServiceProtocol
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.meService = meService
    }
    
    // MARK: - User Data Getting
    func getUserData(completion: @escaping (Result<ConfidentialitySettingsModels.ConfidentialityUserData, any Error>) -> Void) {
        meService.sendGetRestrictionRequest { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let userRestrictions):
                self.userDefaultsManager.saveRestrictions(userRestrictions)
                completion(.success(userRestrictions))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
