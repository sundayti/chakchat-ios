//
//  ProfileSettingsWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 13.02.2025.
//

import Foundation

final class ProfileSettingsWorker: ProfileSettingsScreenWorkerLogic {

    let userDefaultsManager: UserDefaultsManagerProtocol
    let meService: MeServiceProtocol
    
    init(userDefaultsManager: UserDefaultsManagerProtocol,
         meService: MeServiceProtocol
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.meService = meService
    }
    
    func updateUserData(_ request: ProfileSettingsModels.ChangeableProfileUserData, completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        meService.sendPutMeRequest(request) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let newUserData):
                self.userDefaultsManager.saveUserData(newUserData)
                completion(.success(newUserData))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getUserData() -> ProfileSettingsModels.ProfileUserData {
        return userDefaultsManager.loadUserData()
    }
    
}
