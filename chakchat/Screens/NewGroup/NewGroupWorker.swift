//
//  NewGroupWorker.swift
//  chakchat
//
//  Created by лизо4ка курунок on 25.02.2025.
//

import Foundation

// MARK: - NewGroupWorker
final class NewGroupWorker: NewGroupWorkerLogic {
    
    // MARK: - Properties
    private let userService: UserServiceProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    
    // MARK: - Initialization
    init(userService: UserServiceProtocol, keychainManager: KeychainManagerBusinessLogic) {
        self.userService = userService
        self.keychainManager = keychainManager
    }
    
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        print("Request to server")
        userService.sendGetUsersRequest(name, username, page, limit, accessToken) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let users):
                completion(.success(users.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
