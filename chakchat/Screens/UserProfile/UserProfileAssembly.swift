//
//  UserProfileAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit

enum UserProfileAssembly {
    static func build(_ context: MainAppContextProtocol, coordinator: AppCoordinator, userData: ProfileSettingsModels.ProfileUserData) -> UIViewController {
        let presenter = UserProfilePresenter()
        let updateService = UpdateService()
        let personalChatService = PersonalChatService()
        let worker = UserProfileWorker(
            userDefaultsManager: context.userDefaultsManager,
            keychainManager: context.keychainManager,
            coreDataManager: context.coreDataManager,
            personalChatService: personalChatService,
            messagingService: updateService
        )
        let interactor = UserProfileInteractor(
            presenter: presenter,
            worker: worker,
            errorHandler: context.errorHandler,
            userData: userData,
            logger: context.logger
        )
        interactor.onRouteBack = { [weak coordinator] in
            coordinator?.popScreen()
        }
        interactor.onRouteToChat = { [weak coordinator] userData, isChatExisting in
            coordinator?.showChatScreen(userData, isChatExisting)
        }
        let view = UserProfileViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
