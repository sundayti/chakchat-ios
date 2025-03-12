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
    private let eventPublisher: EventPublisherProtocol
    private let userData: ProfileSettingsModels.ProfileUserData
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    
    private var chatData: ChatsModels.GeneralChatModel.ChatData?
    var onRouteBack: (() -> Void)?
    var onRouteToProfile: ((ProfileSettingsModels.ProfileUserData, ChatsModels.GeneralChatModel.ChatData?, ProfileConfiguration) -> Void)?
    
    // MARK: - Initialization
    init(
        presenter: ChatPresentationLogic,
        worker: ChatWorkerLogic,
        userData: ProfileSettingsModels.ProfileUserData,
        eventPublisher: EventPublisherProtocol,
        errorHandler: ErrorHandlerLogic,
        logger: OSLog,
        chatData: ChatsModels.GeneralChatModel.ChatData?
    ) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
        self.eventPublisher = eventPublisher
        self.errorHandler = errorHandler
        self.logger = logger
        self.chatData = chatData
    }
    // если обычный чат еще не создан то он не может быть секретным
    func passUserData() {
        if let chatD = chatData {
            presenter.passUserData(userData, chatD.type.rawValue == "personal_secret")
        } else {
            presenter.passUserData(userData, false)
        }
    }
    
    // MARK: - Public Methods
    func createChat(_ memberID: UUID) {
        worker.createChat(memberID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                os_log("Chat with member(%@) created", log: logger, type: .default, memberID as CVarArg)
                let event = CreatedChatEvent(
                    chatID: data.chatID,
                    type: data.type,
                    members: data.members,
                    createdAt: data.createdAt,
                    info: data.info
                )
                eventPublisher.publish(event: event)
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to create chat with member(%@):\n", log: logger, type: .fault, memberID as CVarArg)
                print(failure)
            }
        }
    }
    
    func sendTextMessage(_ message: String) {
        if chatData == nil {
            createChat(userData.id)
        }
        worker.sendTextMessage(message)
    }
    
    func setExpirationTime(_ expiration: String?) {
        guard let chatID = chatData?.chatID else { return }
        worker.setExpirationTime(chatID, expiration) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
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
    // чат не может быть секретным если даже обычный еще не был создан
    func routeToProfile() {
        if let chatD = chatData {
            let profileConfiguration = ProfileConfiguration(isSecret: chatD.type.rawValue == "personal_secret", fromGroupChat: false)
            onRouteToProfile?(userData, chatD, profileConfiguration)
        } else {
            let profileConfiguration = ProfileConfiguration(isSecret: false, fromGroupChat: false)
            onRouteToProfile?(userData, nil, profileConfiguration)
        }
    }
}
