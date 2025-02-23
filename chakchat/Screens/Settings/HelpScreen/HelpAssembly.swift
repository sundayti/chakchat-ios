//
//  HelpAssembly.swift
//  chakchat
//
//  Created by лизо4ка курунок on 23.02.2025.
//

import UIKit

// MARK: - HelpAssembly
enum HelpAssembly {
    
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = HelpPresenter()
        let interactor = HelpInteractor(presenter: presenter)
        interactor.onRouteToSettingsMenu = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = HelpViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
