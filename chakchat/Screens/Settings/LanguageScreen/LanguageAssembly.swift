//
//  LanguageAssembly.swift
//  chakchat
//
//  Created by лизо4ка курунок on 15.02.2025.
//

import UIKit

// MARK: - LanguageAssembly
enum LanguageAssembly {
    
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = LanguagePresenter()
        let interactor = LanguageInteractor(presenter: presenter)
        interactor.onRouteToSettingsMenu = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = LanguageViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
