//
//  ConfidentialityScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import UIKit

// MARK: - ConfidentialityScreenAssembly
enum ConfidentialityScreenAssembly {
    
    // MARK: - Confidentiality Screen Assembly Method
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = ConfidentialityScreenPresenter()
        let meService = MeService()
        let worker = ConfidentialityScreenWorker(userDefaultsManager: context.userDefaultsManager,
                                                 meService: meService)
        let interactor = ConfidentialityScreenInteractor(presenter: presenter,
                                                         worker: worker,
                                                         errorHandler: context.errorHandler,
                                                         eventSubscriber: context.eventManager,
                                                         logger: context.logger)
        
        interactor.onRouteToSettingsMenu = { [weak coordinator] in
            coordinator?.popScreen()
        }
        
        interactor.onRouteToPhoneVisibilityScreen = { [weak coordinator] in
            coordinator?.showPhoneVisibilityScreen()
        }
        
        interactor.onRouteToBirthVisibilityScreen = { [weak coordinator] in
            coordinator?.showBirthVisibilityScreen()
        }
        
        interactor.onRouteToOnlineVisibilityScreen = { [weak coordinator] in
            coordinator?.showOnlineVisibilityScreen()
        }
        
        let view = ConfidentialityScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

