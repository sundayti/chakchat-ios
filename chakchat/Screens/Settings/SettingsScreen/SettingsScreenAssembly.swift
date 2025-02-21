//
//  SettingsScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit

// MARK: - SettingsScreenAssembly
enum SettingsScreenAssembly {
    
    // MARK: - Setting Screen Assembly Method
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = SettingsScreenPresenter()
        let userService = UserService()
        let worker = SettingsScreenWorker(userDefaultsManager: context.userDefaultsManager, userService: userService, keychainManager: context.keychainManager)
       
        let interactor = SettingsScreenInteractor(presenter: presenter,
                                                  worker: worker,
                                                  eventSubscriber: context.eventManager, 
                                                  errorHandler: context.errorHandler,
                                                  logger: context.logger
        )
        interactor.onRouteToUserProfileSettings = { [weak coordinator] in
            coordinator?.showUserSettingsScreen()
        }
        interactor.onRouteToConfidentialitySettings = { [weak coordinator] in
            coordinator?.showConfidentialityScreen()
        }
        interactor.onRouteToNotificationsSettings = { [weak coordinator] in
            coordinator?.showNotificationScreen()
        }
        interactor.onRouteToLanguageSettings = { [weak coordinator] in
            coordinator?.showLanguageScreen()
        }
        
        let view = SettingsScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
