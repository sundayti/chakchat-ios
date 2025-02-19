//
//  PhoneVisibilityScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - PhoneVisibilityScreenWorker
final class PhoneVisibilityScreenWorker: PhoneVisibilityScreenWorkerLogic {
    
    // MARK: - Properties
    let userDefaultsManager: UserDefaultsManagerProtocol
    let meService: UserServiceProtocol
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol,
         meService: UserServiceProtocol
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.meService = meService
    }
    
    func updateUserRestriction(_ request: ConfidentialitySettingsModels.ConfidentialityUserData, completion: @escaping (Result<Void, any Error>) -> Void) {
        meService.sendPutRestrictionRequest(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(()):
                self.userDefaultsManager.saveRestrictions(request)
                completion(.success(()))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func saveNewRestrictions(_ newUserRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        userDefaultsManager.saveRestrictions(newUserRestrictions)
    }
}
