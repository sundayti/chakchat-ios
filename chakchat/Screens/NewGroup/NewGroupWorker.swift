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
    private let groupChatService: GroupChatServiceProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let coreDataManager: CoreDataManagerProtocol
    
    // MARK: - Initialization
    init(
        userService: UserServiceProtocol,
        groupChatService: GroupChatServiceProtocol,
        keychainManager: KeychainManagerBusinessLogic,
        userDefaultsManager: UserDefaultsManagerProtocol,
        coreDataManager: CoreDataManagerProtocol
    ) {
        self.userService = userService
        self.groupChatService = groupChatService
        self.keychainManager = keychainManager
        self.userDefaultsManager = userDefaultsManager
        self.coreDataManager = coreDataManager
    }
    
    func createGroupChat(_ name: String, _ description: String?, _ members: [UUID], completion: @escaping (Result<ChatsModels.GroupChat.Response, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        let adminID = getMyID()
        let membersWithAdmin: [UUID] = [adminID] + members
        let request = ChatsModels.GroupChat.CreateRequest(name: name, description: description, members: membersWithAdmin)
        groupChatService.sendCreateChatRequest(request, accessToken) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                // сохраняем в coreData
                completion(.success(response.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
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
    
    private func getMyID() -> UUID {
        let myID = userDefaultsManager.loadID()
        return myID
    }
}
