//
//  NewMessageWorker.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import Foundation

// MARK: - NewMessageWorker
final class NewMessageWorker: NewMessageWorkerLogic {
    
    // MARK: - Properties
    private let userService: UserServiceProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let coreDataManager: CoreDataManagerProtocol
    
    // MARK: - Initialization
    init(
        userService: UserServiceProtocol,
        keychainManager: KeychainManagerBusinessLogic,
        userDefaultsManager: UserDefaultsManagerProtocol,
        coreDataManager: CoreDataManagerProtocol
    ) {
        self.userService = userService
        self.keychainManager = keychainManager
        self.userDefaultsManager = userDefaultsManager
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Public Methods
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
    
    func searchForExistingChat(_ memberID: UUID) -> Chat? {
        let myID = getMyID()
        let chat = coreDataManager.fetchChatByMembers(myID, memberID, ChatType.personal)
        return chat != nil ? chat : nil
    }
    
    func getMyID() -> UUID {
        let myID = userDefaultsManager.loadID()
        return myID
    }
}
