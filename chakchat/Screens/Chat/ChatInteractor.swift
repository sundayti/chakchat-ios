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
    private var chatID: UUID?
    private let isSecret: Bool
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    
    var onRouteBack: (() -> Void)?
    var onRouteToProfile: ((ProfileSettingsModels.ProfileUserData, ProfileConfiguration) -> Void)?
    
    // MARK: - Initialization
    init(
        presenter: ChatPresentationLogic,
        worker: ChatWorkerLogic,
        userData: ProfileSettingsModels.ProfileUserData,
        eventPublisher: EventPublisherProtocol,
        isChatExisting: Bool,
        chatID: UUID?,
        isSecret: Bool,
        errorHandler: ErrorHandlerLogic,
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
        self.eventPublisher = eventPublisher
        self.isChatExisting = isChatExisting
        self.chatID = chatID
        self.isSecret = isSecret
        self.errorHandler = errorHandler
        self.logger = logger
    }
    
    func passUserData() {
        presenter.passUserData(userData, isSecret)
    }
    
    // MARK: - Public Methods
    func createChat(_ memberID: UUID) {
        worker.createChat(memberID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                os_log("Chat with member(%@) created", log: logger, type: .default, memberID as CVarArg)
                // если blocked == true, то показываем пользователю об этом.
                let event = CreatedPersonalChatEvent(
                    chatID: data.chatID,
                    members: data.members,
                    blocked: data.blocked,
                    blockedBy: data.blockedBy,
                    createdAt: data.createdAt
                )
                eventPublisher.publish(event: event)
                self.chatID = data.chatID
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to create chat with member(%@):\n", log: logger, type: .fault, memberID as CVarArg)
                print(failure)
            }
        }
    }
    
    func sendTextMessage(_ message: String) {
        if !isChatExisting {
            createChat(userData.id)
        }
        worker.sendTextMessage(message)
    }
    
    func setExpirationTime(_ expiration: String?) {
        guard let chatID = chatID else { return }
        worker.setExpirationTime(chatID, expiration) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                os_log("Setted expiration time with member(%@)", log: logger, type: .default, userData.id as CVarArg)
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to set expiration time with member(%@)", log: logger, type: .default, userData.id as CVarArg)
                print(failure)
            }
        }
    }
    
    // MARK: - Routing
    func routeBack() {
        onRouteBack?()
    }
    
    func routeToProfile() {
        let profileConfiguration = ProfileConfiguration(isSecret: isSecret, fromGroupChat: false)
        onRouteToProfile?(userData, profileConfiguration)
    }
}
