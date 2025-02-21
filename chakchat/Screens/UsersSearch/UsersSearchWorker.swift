//
//  UsersSearchWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.02.2025.
//

import Foundation

final class UsersSearchWorker: UsersSearchWorkerLogic {
    private let keychainManager: KeychainManagerBusinessLogic
    private let userService: UserServiceProtocol
    
    init(keychainManager: KeychainManagerBusinessLogic, 
         userService: UserServiceProtocol
    ) {
        self.keychainManager = keychainManager
        self.userService = userService
    }
    
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        userService.sendGetUsersRequest(name, username, page, limit, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                completion(.success(users.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
