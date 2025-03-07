//
//  UserProfileWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit

// MARK: - UserProfileWorker
final class UserProfileWorker: UserProfileWorkerLogic {
    
    // MARK: - Properties
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    private let coreDataManager: CoreDataManagerProtocol
    private let personalChatService: PersonalChatServiceProtocol
    private let messagingService: UpdateServiceProtocol
    
    // MARK: - Initialization
    init(
        userDefaultsManager: UserDefaultsManagerProtocol,
        keychainManager: KeychainManagerBusinessLogic,
        coreDataManager: CoreDataManagerProtocol,
        personalChatService: PersonalChatServiceProtocol,
        messagingService: UpdateServiceProtocol
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.keychainManager = keychainManager
        self.coreDataManager = coreDataManager
        self.personalChatService = personalChatService
        self.messagingService = messagingService
    }
    
    // MARK: - Searching for Existing Chat
    // return true if chat exists else false
    func searchForExistingChat(_ memberID: UUID) -> Bool {
        let myID = getMyID()
        let chat = coreDataManager.fetchChatByMembers(myID, memberID)
        return chat != nil ? true : false
    }
    
    // MARK: - Getting ID
    func getMyID() -> UUID {
        let myID = userDefaultsManager.loadID()
        return myID
    }

    // MARK: - Blocking Chat
    func blockChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.PersonalChat.Response, any Error>) -> Void) {
        let myID = getMyID()
        guard let chatID = coreDataManager.fetchChatByMembers(myID, memberID)?.chatID else {
            completion(.failure(NSError(domain: "Chat does not exist", code: 1)))
            return
        }
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        personalChatService.sendBlockChatRequest(chatID, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.coreDataManager.updateChat(response.data)
                completion(.success(response.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    // MARK: - Unblocking Chat
    func unblockChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.PersonalChat.Response, any Error>) -> Void) {
        let myID = getMyID()
        guard let chatID = coreDataManager.fetchChatByMembers(myID, memberID)?.chatID else {
            completion(.failure(NSError(domain: "Chat does not exist", code: 1)))
            return
        }
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        personalChatService.sendUnblockRequest(chatID, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.coreDataManager.updateChat(response.data)
                completion(.success(response.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
            
        }
    }
    
    // MARK: - Deleting Chat
    func deleteChat(_ memberID: UUID, _ deleteMode: DeleteMode, completion: @escaping (Result<EmptyResponse, any Error>) -> Void) {
        let myID = getMyID()
        guard let chatID = coreDataManager.fetchChatByMembers(myID, memberID)?.chatID else {
            completion(.failure(NSError(domain: "Chat does not exist", code: 1)))
            return
        }
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        personalChatService.sendDeleteChatRequest(chatID, deleteMode, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.coreDataManager.deleteChat(chatID)
                completion(.success(response.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func searchMessages() {
        /// имплементация позже
    }
    
    func switchNotification() {
        /// имплементация позже
    }
}
