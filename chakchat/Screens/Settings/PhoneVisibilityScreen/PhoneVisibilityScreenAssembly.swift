//
//  PhoneVisibilityScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit

// MARK: - PhoneVisibilityScreenAssembly
enum PhoneVisibilityScreenAssembly {
    
    // MARK: - Phone Visibility Screen Assembly Method
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = PhoneVisibilityScreenPresenter()
        let meService = MeService()
        let worker = PhoneVisibilityScreenWorker(userDefaultsManager: context.userDefaultsManager, meService: meService)
        let interactor = PhoneVisibilityScreenInteractor(presenter: presenter,
                                                         worker: worker,
                                                         eventManager: context.eventManager,
                                                         errorHandler: context.errorHandler,
                                                         logger: context.logger,
                                                         userRestrictionsSnap: context.userDefaultsManager.loadRestrictions()
        )
        interactor.onRouteToConfidentialityScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = PhoneVisibilityScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

