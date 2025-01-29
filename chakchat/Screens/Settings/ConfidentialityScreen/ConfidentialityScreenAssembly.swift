//
//  ConfidentialityScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import UIKit
enum ConfidentialityScreenAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = ConfidentialityScreenPresenter()
        let worker = ConfidentialityScreenWorker(userDefaultsManager: context.userDefaultManager)
        let interactor = ConfidentialityScreenInteractor(presenter: presenter, worker: worker, eventPublisher: context.eventManager)
        
        interactor.onRouteToSettingsMenu = { [weak coordinator] in
            coordinator?.popScreen()
        }
        
        let view = ConfidentialityScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
