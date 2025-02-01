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
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = SettingsScreenPresenter()
        let worker = SettingsScreenWorker(userDefaultsManager: context.userDefaultManager)
        let userData = getUserData(context.userDefaultManager)
        let interactor = SettingsScreenInteractor(presenter: presenter, worker: worker, userData: userData)
        interactor.onRouteToProfileSettings = { [weak coordinator] in
            coordinator?.showProfileSettingsScreen()
        }
        interactor.onRouteToConfidentialitySettings = { [weak coordinator] in
            coordinator?.showConfidentialityScreen()
        }
        context.eventManager.register(eventType: UpdateProfileDataEvent.self,
                                      interactor.handleUserDataChangedEvent)
        
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
