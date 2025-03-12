//
//  NewMessageAssembly.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import UIKit

// MARK: - NewMessageAssembly
enum NewMessageAssembly {
    
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = NewMessagePresenter()
        let userService = UserService()
        let worker = NewMessageWorker(
            userService: userService,
            keychainManager: context.keychainManager,
            userDefaultsManager: context.userDefaultsManager,
            coreDataManager: context.coreDataManager
        )
        let interactor = NewMessageInteractor(
            presenter: presenter,
            worker: worker,
            errorHandler: context.errorHandler
        )
        interactor.onRouteToChatsScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        interactor.onRouteToNewMessageScreen = { [weak coordinator] in
            coordinator?.showNewGroupScreen()
        }
        interactor.onRouteToChat = { [weak coordinator] userData, chatData in
            coordinator?.showChatScreen(userData, chatData)
        }
        let view = NewMessageViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
