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
    private let coreDataManager: CoreDataManagerProtocol
    private let userService: UserServiceProtocol
    private let logger: OSLog
    
    init(keychainManager: KeychainManagerBusinessLogic,
         userDefaultManager: UserDefaultsManagerProtocol,
         userService: UserServiceProtocol,
         coreDataManager: CoreDataManagerProtocol,
         logger: OSLog
    ) {
        self.keychainManager = keychainManager
        self.userDefaultManager = userDefaultManager
        self.coreDataManager = coreDataManager
        self.userService = userService
        self.logger = logger
    }
    
    func loadChats() -> [ChatsModels.PersonalChat.Response]? {
        var result: [ChatsModels.PersonalChat.Response] = []
        if let chats = coreDataManager.fetchChats() {
            for chat in chats {
                guard let members = try? JSONDecoder().decode([UUID].self, from: chat.members) else { continue }
                let chatResponse = ChatsModels.PersonalChat.Response(
                    chatID: chat.chatID,
                    members: members,
                    blocked: chat.blocked,
                    blockedBy: try? JSONDecoder().decode([UUID]?.self, from: chat.blockedBy ?? Data()),
                    createdAt: chat.createdAt
                )
                result.append(chatResponse)
            }
        }
        return result
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
            case .success(let response):
                os_log("Fetching users completed", log: self.logger, type: .default)
                coreDataManager.createUsers(response.data)
                completion(.success(response.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getUserDataByID(_ users: [UUID], completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        let myID = userDefaultManager.loadID()
        for usr in users where usr != myID {
            userService.sendGetUserRequest(usr, accessToken) { [weak self] result in
                guard self != nil else { return }
                switch result {
                case .success(let response):
                    completion(.success(response.data))
                case .failure(let failure):
                    completion(.failure(failure))
                }
            }
        }
    }
}
