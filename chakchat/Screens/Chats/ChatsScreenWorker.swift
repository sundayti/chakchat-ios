//
//  ChatsScreenWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit
import OSLog

// MARK: - ChatsScreenWorker
final class ChatsScreenWorker: ChatsScreenWorkerLogic {
    private let keychainManager: KeychainManagerBusinessLogic
    private let userDefaultManager: UserDefaultsManagerProtocol
    private let userService: UserServiceProtocol
    private let logger: OSLog
    
    init(keychainManager: KeychainManagerBusinessLogic,
         userDefaultManager: UserDefaultsManagerProtocol,
         userService: UserServiceProtocol,
         logger: OSLog
    ) {
        self.keychainManager = keychainManager
        self.userDefaultManager = userDefaultManager
        self.userService = userService
        self.logger = logger
    }
    
    func loadMeData(competion: @escaping (Result<Void, Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        userService.sendGetMeRequest(accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.userDefaultManager.saveUserData(response.data)
            case .failure(let failure):
                competion(.failure(failure))
            }
        }
    }
    
    func loadMeRestrictions(completion: @escaping (Result<Void, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        userService.sendGetRestrictionRequest(accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.userDefaultManager.saveRestrictions(response.data)
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        userService.sendGetUsersRequest(name, username, page, limit, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                os_log("Fetching users completed", log: self.logger, type: .default)
                completion(.success(users.data))
            case .failure(let failure):
                os_log("Fetching users failed:\n", log: self.logger, type: .fault)
                print(failure)
                completion(.failure(failure))
            }
        }
    }
}
