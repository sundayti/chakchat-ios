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
    private let meService: MeServiceRestrictionProtocol
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol,
         meService: MeServiceRestrictionProtocol
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.meService = meService
    }
    
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
