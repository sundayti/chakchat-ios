//
//  ProfileSettingsAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit
enum ProfileSettingsAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = ProfileSettingsPresenter()
        let worker = ProfileSettingsWorker(userDefaultsManager: context.userDefaultManager)
        let userData = getUserProfileData(context.userDefaultManager)
        let interactor = ProfileSettingsInteractor(presenter: presenter, 
                                                   worker: worker, userData: userData,
                                                   eventPublisher: context.eventManager)
        
        interactor.onRouteToSettingsMenu = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = ProfileSettingsViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

private func getUserProfileData(_ userDefaultsManager: UserDefaultsManagerProtocol) -> ProfileSettingsModels.ProfileUserData {
    let nickname = userDefaultsManager.loadNickname()
    let username = userDefaultsManager.loadUsername()
    return ProfileSettingsModels.ProfileUserData(nickname: nickname, username: username)
}
