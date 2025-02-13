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
    let userDeafultsManager: UserDefaultsManagerProtocol
    let meService: MeServiceRestrictionProtocol
    
    // MARK: - Initialization
    init(userDeafultsManager: UserDefaultsManagerProtocol, meService: MeServiceRestrictionProtocol) {
        self.userDeafultsManager = userDeafultsManager
        self.meService = meService
    }
    
    func updateUserRestriction(_ request: ConfidentialitySettingsModels.ConfidentialityUserData, completion: @escaping (Result<Void, any Error>) -> Void) {
        meService.sendPutRestrictionRequest(request) { [weak self] result in
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
