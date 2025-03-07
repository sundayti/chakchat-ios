//
//  ChatsScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit
import OSLog
import Combine

// MARK: - ChatsScreenInteractor
final class ChatsScreenInteractor: ChatsScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ChatsScreenPresentationLogic
    private let worker: ChatsScreenWorkerLogic
    private let logger: OSLog
    private let errorHandler: ErrorHandlerLogic
    private let eventSubscriber: EventSubscriberProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    
    private var cancellables = Set<AnyCancellable>()
    
    var onRouteToSettings: (() -> Void)?
    var onRouteToNewMessage: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ChatsScreenPresentationLogic, 
         worker: ChatsScreenWorkerLogic,
         logger: OSLog,
         errorHandler: ErrorHandlerLogic,
         eventSubscriber: EventSubscriberProtocol,
         keychainManager: KeychainManagerBusinessLogic
    ) {
        self.presenter = presenter
        self.worker = worker
        self.logger = logger
        self.errorHandler = errorHandler
        self.eventSubscriber = eventSubscriber
        self.keychainManager = keychainManager
        
        subscribeToEvents()
    }
    
    // MARK: - Routing
    func routeToSettingsScreen() {
        os_log("Routed to settings screen", log: logger, type: .default)
        onRouteToSettings?()
    }
    
    func routeToNewMessageScreen() {
        os_log("Routed to new message screen", log: logger, type: .default)
        onRouteToNewMessage?()
    }
    
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, any Error>) -> Void) {
        worker.fetchUsers(name, username, page, limit) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    private func subscribeToEvents() {
        eventSubscriber.subscribe(CreatedPersonalChatEvent.self) { [weak self] event in
            self?.handleChatCreatingEvent(event)
        }.store(in: &cancellables)
    }
    
    func loadChats() {
        print("Загрузили чаты")
    }
    
    func handleChatCreatingEvent(_ event: CreatedPersonalChatEvent) {
        let chatData = ChatsModels.PersonalChat.Response(
            chatID: event.chatID,
            members: event.members,
            blocked: event.blocked,
            blockedBy: event.blockedBy,
            createdAt: event.createdAt
        )
        addNewChat(chatData)
    }
    
    func addNewChat(_ chatData: ChatsModels.PersonalChat.Response) {
        presenter.addNewChat(chatData)
    }
    
    func getUserDataByID(_ users: [UUID], completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void) {
        worker.getUserDataByID(users) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func handleError(_ error: Error) {
        _ = errorHandler.handleError(error)
    }
}
