//
//  AppThemeAssembly.swift
//  chakchat
//
//  Created by лизо4ка курунок on 22.02.2025.
//

import UIKit

// MARK: - AppThemeAssembly
enum AppThemeAssembly {
    
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = AppThemePresenter()
        let interactor = AppThemeInteractor(presenter: presenter)
        interactor.onRouteToSettingsMenu = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = AppThemeViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
