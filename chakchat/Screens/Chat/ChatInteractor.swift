//
//  Chatinteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import Foundation
import OSLog

final class ChatInteractor: ChatBusinessLogic {
    private let presenter: ChatPresentationLogic
    private let worker: ChatWorkerLogic
    private let userData: ProfileSettingsModels.ProfileUserData
    private let isChatExisting: Bool
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    
    var onRouteBack: (() -> Void)?
    
    init(
        presenter: ChatPresentationLogic,
        worker: ChatWorkerLogic,
        userData: ProfileSettingsModels.ProfileUserData,
        isChatExisting: Bool,
        errorHandler: ErrorHandlerLogic,
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
        self.isChatExisting = isChatExisting
        self.errorHandler = errorHandler
        self.logger = logger
    }
    
    func createChat(_ memberID: UUID) {
        worker.createChat(memberID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                os_log("Chat created", log: logger, type: .default)
                // если blocked == true, то показываем пользователю об этом.
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to create chat:\n", log: logger, type: .fault)
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
    
    func passUserData() {
        presenter.passUserData(userData)
    }
    
    func routeBack() {
        onRouteBack?()
    }
}
