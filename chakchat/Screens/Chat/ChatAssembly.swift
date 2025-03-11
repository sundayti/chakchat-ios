//
//  ChatAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit

// MARK: - ChatAssembly
enum ChatAssembly {
    
    static func build(
        _ context: MainAppContextProtocol,
        coordinator: AppCoordinator,
        userData: ProfileSettingsModels.ProfileUserData,
        chatID: UUID?,
        existing: Bool,
        isSecret: Bool = false
    ) -> UIViewController {
        
        let presenter = ChatPresenter()
        let personalChatService = PersonalChatService()
        let secretPersonalChatService = SecretPersonalChatService()
        let updateService = UpdateService()
        
        let worker = ChatWorker(
            keychainManager: context.keychainManager,
            coreDataManager: context.coreDataManager,
            personalChatService: personalChatService,
            secretPersonalChatService: secretPersonalChatService,
            updateService: updateService
        )
        
        let interactor = ChatInteractor(
            presenter: presenter,
            worker: worker,
            userData: userData,
            eventPublisher: context.eventManager,
            isChatExisting: existing,
            chatID: chatID,
            isSecret: isSecret,
            errorHandler: context.errorHandler,
            logger: context.logger
        )
        interactor.onRouteToProfile = { [weak coordinator] userData, profileConfiguration in
            coordinator?.showUserProfileScreen(userData, profileConfiguration)
        }
        interactor.onRouteBack = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = ChatViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
