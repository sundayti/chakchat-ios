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
        let interactor = UserProfileScreenInteractor(preseter: presenter,
                                                     worker: worker,
                                                     eventSubscriber: context.eventManager,
                                                     errorHandler: context.errorHandler,
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
