//
//  SettingsScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation

// MARK: - SettingsScreenWorker
final class SettingsScreenWorker: SettingsScreenWorkerLogic {
    
    // MARK: - Properties
    let userDefaultsManager: UserDefaultsManagerProtocol
    let meService: MeServiceProtocol
    
    // MARK: - Initialization
    init(userDefaultsManager: UserDefaultsManagerProtocol, 
         meService: MeServiceProtocol
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.meService = meService
    }
    
    func getUserData(completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        meService.sendGetMeRequest { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let userData):
                self.userDefaultsManager.saveUserData(userData)
                completion(.success(userData))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
