//
//  ProfileSettingsAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit

// MARK: - ProfileSettingsAssembly
enum ProfileSettingsAssembly {
    
    // MARK: - Profile Setting Assembly Method
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = ProfileSettingsPresenter()
        let worker = ProfileSettingsWorker(userDefaultsManager: context.userDefaultsManager)
        let userData = getUserProfileData(context.userDefaultsManager)
        let interactor = ProfileSettingsInteractor(presenter: presenter, 
                                                   worker: worker, userData: userData,
                                                   eventPublisher: context.eventManager,
                                                   logger: context.logger
        )
        
        interactor.onRouteToSettingsMenu = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = ProfileSettingsViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

// MARK: - User Profile Data Getting
private func getUserProfileData(_ userDefaultsManager: UserDefaultsManagerProtocol) -> ProfileSettingsModels.ProfileUserData {
    let nickname = userDefaultsManager.loadNickname()
    let username = userDefaultsManager.loadUsername()
    let phone = userDefaultsManager.loadPhone()
    let birth = userDefaultsManager.loadBirth()
    return ProfileSettingsModels.ProfileUserData(id: UUID(), nickname: nickname, username: username, phone: phone, dateOfBirth: birth)
}
