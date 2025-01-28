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
        var presenter = ConfidentialityScreenPresenter()
        var worker = ConfidentialityScreenWorker(userDefaultsManager: context.userDefaultManager)
        var interactor = ConfidentialityScreenInteractor(presenter: presenter, worker: worker, eventPublisher: context.eventManager)
        
        interactor.onRouteToSettingsMenu = { [weak coordinator] in
            coordinator?.popScreen()
        }
        
        var view = ConfidentialityScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
