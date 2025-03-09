//
//  GroupChatProfileWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

final class GroupChatProfileWorker: GroupChatProfileWorkerLogic {
    private let keychainManager: KeychainManagerBusinessLogic
    private let groupService: GroupChatServiceProtocol
    private let coreDataManager: CoreDataManagerProtocol
    
    init(
        keychainManager: KeychainManagerBusinessLogic,
        groupService: GroupChatServiceProtocol,
        coreDataManager: CoreDataManagerProtocol
    ) {
        self.keychainManager = keychainManager
        self.groupService = groupService
        self.coreDataManager = coreDataManager
    }
    
    func deleteGroup(_ chatID: UUID, completion: @escaping (Result<EmptyResponse, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        groupService.sendDeleteChatRequest(chatID, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func addMember(_ chatID: UUID, _ memberID: UUID, completion: @escaping (Result<ChatsModels.GroupChat.Response, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        groupService.sendAddMemberRequest(chatID, memberID, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                // сохраняем в coreData
                completion(.success(response.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func deleteMember(_ chatID: UUID, _ memberID: UUID, completion: @escaping (Result<ChatsModels.GroupChat.Response, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        groupService.sendDeleteMemberRequest(chatID, memberID, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                // сохраняем в coreData
                completion(.success(response.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
