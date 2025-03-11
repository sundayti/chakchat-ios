//
//  UserProfileInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit
import OSLog

// MARK: - UserProfileInteractor
final class UserProfileInteractor: UserProfileBusinessLogic {
    
    // MARK: - Properties
    private let presenter: UserProfilePresentationLogic
    private let worker: UserProfileWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let userData: ProfileSettingsModels.ProfileUserData
    private let profileConfiguration: ProfileConfiguration
    private let logger: OSLog
    
    var onRouteToChat: ((ProfileSettingsModels.ProfileUserData, ChatsModels.GeneralChatModel.ChatData?) -> Void)?
    var onRouteBack: (() -> Void)?
    
    // MARK: - Initialization
    init(
        presenter: UserProfilePresentationLogic,
        worker: UserProfileWorkerLogic,
        errorHandler: ErrorHandlerLogic,
        userData: ProfileSettingsModels.ProfileUserData,
        profileConfiguration: ProfileConfiguration,
        logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.errorHandler = errorHandler
        self.userData = userData
        self.profileConfiguration = profileConfiguration
        self.logger = logger
    }
    
    // MARK: - Public Methods
    func passUserData() {
        presenter.passUserData(userData, profileConfiguration)
    }
    
    func createSecretChat() {
        print("fawf")
    }
    
    func blockChat() {
        worker.blockChat(userData.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                os_log("Chat with id:%@ is blocked", log: logger, type: .default, data.chatID as CVarArg)
                // событие по блокировке чата
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to block chat with %@", log: logger, type: .fault, userData.id as CVarArg)
                print(failure)
            }
        }
    }
    
    func unblockChat() {
        worker.unblockChat(userData.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                os_log("Chat with id:%@ is unblocked", log: logger, type: .default, userData.id as CVarArg)
                // событие по разблокировке чата
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to unblock chat with %@", log: logger, type: .fault, userData.id as CVarArg)
                print(failure)
            }
        }
    }
    
    func deleteChat(_ deleteMode: DeleteMode) {
        worker.deleteChat(userData.id, deleteMode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                os_log("Chat with id:%@ is deleted", log: logger, type: .default, userData.id as CVarArg)
                // событие по удалению чата
            case .failure(let failure):
                _ = errorHandler.handleError(failure)
                os_log("Failed to delete chat with %@", log: logger, type: .fault, userData.id as CVarArg)
                print(failure)
            }
        }
    }
    
    func searchForExistingChat() {
        if let chatData = worker.searchForExistingChat(userData.id) {
            let convertedChatData = convertData(chatData)
            routeToChat(convertedChatData)
        } else {
            routeToChat(nil)
        }
    }
    
    func switchNotification() {
        /// сделать сохранение текущего состояния через userDefaultsManager, а может быть нужно как-то иначе сделать
        /// пока что реализация под вопросом
    }
    
    func searchMessages() {
        /// сделать через /{chatId}/update/message/search позже
    }
    
    // MARK: - Routing
    func routeToChat(_ isChatExisting: ChatsModels.GeneralChatModel.ChatData?) {
        onRouteToChat?(userData, isChatExisting)
    }
    
    func routeBack() {
        onRouteBack?()
    }
    
    private func convertData(_ chatCoreData: Chat) -> ChatsModels.GeneralChatModel.ChatData? {
        let decoder = JSONDecoder()
        let chatData = ChatsModels.GeneralChatModel.ChatData(
            chatID: chatCoreData.chatID,
            type: ChatType(rawValue: chatCoreData.type) ?? ChatType.personal,
            members: (try? decoder.decode([UUID].self, from: chatCoreData.members)) ?? [UUID()],
            createdAt: chatCoreData.createdAt,
            info: (try? decoder.decode(ChatsModels.GeneralChatModel.Info.self, from: chatCoreData.info))
            ?? ChatsModels.GeneralChatModel.Info.personal(ChatsModels.GeneralChatModel.PersonalInfo(blockedBy: [UUID()]))
        )
        return chatData
    }
}
