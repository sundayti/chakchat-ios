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
        let worker = SettingsScreenWorker(userDefaultsManager: context.userDefaultsManager)
        let userData = getUserData(context.userDefaultsManager)
        let interactor = SettingsScreenInteractor(presenter: presenter, 
                                                  worker: worker, 
                                                  userData: userData,
                                                  eventSubscriber: context.eventManager,
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
        
        let view = SettingsScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

// MARK: - User Data Getting
private func getUserData(_ userDefaultsManager: UserDefaultsManagerProtocol) -> SettingsScreenModels.UserData {
    let nickname = userDefaultsManager.loadNickname()
    let username = userDefaultsManager.loadUsername()
    let phone = userDefaultsManager.loadPhone()
    return SettingsScreenModels.UserData(nickname: nickname, username: username, phone: phone)
}
