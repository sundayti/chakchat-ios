//
//  Chatinteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import Foundation
import OSLog

// MARK: - ChatInteractor
final class ChatInteractor: ChatBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ChatPresentationLogic
    private let worker: ChatWorkerLogic
    private let userData: ProfileSettingsModels.ProfileUserData
    private let eventPublisher: EventPublisherProtocol
    private let isChatExisting: Bool
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    
    var onRouteBack: (() -> Void)?
    
    // MARK: - Initialization
    init(
        presenter: ChatPresentationLogic,
        worker: ChatWorkerLogic,
        userData: ProfileSettingsModels.ProfileUserData,
        eventPublisher: EventPublisherProtocol,
        isChatExisting: Bool,
        errorHandler: ErrorHandlerLogic,
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
        self.eventPublisher = eventPublisher
        self.isChatExisting = isChatExisting
        self.errorHandler = errorHandler
        self.logger = logger
    }
    
    // MARK: - Chat Creating
    func createChat(_ memberID: UUID) {
        worker.createChat(memberID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                os_log("Chat created", log: logger, type: .default)
                // если blocked == true, то показываем пользователю об этом.
                let event = CreatedPersonalChatEvent(
                    chatID: data.chatID,
                    members: data.members,
                    blocked: data.blocked,
                    blockedBy: data.blockedBy,
                    createdAt: data.createdAt
                )
                eventPublisher.publish(event: event)
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to create chat:\n", log: logger, type: .fault)
                print(failure)
            }
        }
    }
    
    // MARK: - Text Message Sending
    func sendTextMessage(_ message: String) {
        if !isChatExisting {
            createChat(userData.id)
        }
        worker.sendTextMessage(message)
    }
    
    // MARK: - Passing User data
    func passUserData() {
        presenter.passUserData(userData)
    }
    
    // MARK: - Routing
    func routeBack() {
        onRouteBack?()
    }
}
