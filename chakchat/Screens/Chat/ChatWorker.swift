//
//  ChatWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import Foundation

final class ChatWorker: ChatWorkerLogic {
    private let keychainManager: KeychainManagerBusinessLogic
    private let coreDataManager: CoreDataManagerProtocol
    private let personalChatService: PersonalChatServiceProtocol
    private let updateService: UpdateServiceProtocol
    
    init(
        keychainManager: KeychainManagerBusinessLogic,
        coreDataManager: CoreDataManagerProtocol,
        personalChatService: PersonalChatServiceProtocol,
        updateService: UpdateServiceProtocol
    ) {
        self.keychainManager = keychainManager
        self.coreDataManager = coreDataManager
        self.personalChatService = personalChatService
        self.updateService = updateService
    }
    
    func createChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.PersonalChat.Response, any Error>) -> Void) {
        guard let accessToken = keychainManager.getString(key: KeychainManager.keyForSaveAccessToken) else { return }
        let request = ChatsModels.PersonalChat.CreateRequest(memberID: memberID)
        personalChatService.sendCreateChatRequest(request, accessToken) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                // сохранить ответ в coreData
                completion(.success(response.data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
