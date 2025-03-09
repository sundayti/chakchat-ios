//
//  BirthVisibilityScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit

// MARK: - BirthVisibilityScreenAssembly
enum BirthVisibilityScreenAssembly {
    
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = BirthVisibilityScreenPresenter()
        let userService = UserService()
        let worker = BirthVisibilityScreenWorker(userDeafultsManager: context.userDefaultsManager, userService: userService, keychainManager: context.keychainManager)
        let interactor = BirthVisibilityScreenInteractor(presenter: presenter,
                                                         worker: worker,
                                                         eventManager: context.eventManager,
                                                         errorHandler: context.errorHandler,
                                                         logger: context.logger,
                                                         userRestrictionsSnap: context.userDefaultsManager.loadRestrictions()
        )
        interactor.onRouteToConfidentialityScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = BirthVisibilityScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

