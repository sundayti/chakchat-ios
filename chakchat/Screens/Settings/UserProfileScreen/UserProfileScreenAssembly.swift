//
//  UserProfileScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//

import Foundation
import UIKit

enum UserProfileScreenAssembly {
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = UserProfileScreenPresenter()
        let worker = UserProfileScreenWorker(userDefaultsManager: context.userDefaultsManager)
        let userData = getUserProfileData(context.userDefaultsManager)
        let interactor = UserProfileScreenInteractor(preseter: presenter,
                                                     worker: worker,
                                                     userData: userData, 
                                                     eventSubscriber: context.eventManager,
                                                     logger: context.logger)
        interactor.onRouteToSettingsScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        interactor.onRouteToProfileSettingsScreen = { [weak coordinator] in
            coordinator?.showProfileSettingsScreen()
        }
        let view = UserProfileScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

private func getUserProfileData(_ userDefaultsManager: UserDefaultsManagerProtocol) -> ProfileSettingsModels.ProfileUserData {
    let nickname = userDefaultsManager.loadNickname()
    let username = userDefaultsManager.loadUsername()
    let phone = userDefaultsManager.loadPhone()
    let birth = userDefaultsManager.loadBirth()
    return ProfileSettingsModels.ProfileUserData(id: UUID(), nickname: nickname, username: username, phone: phone, dateOfBirth: birth)
}
