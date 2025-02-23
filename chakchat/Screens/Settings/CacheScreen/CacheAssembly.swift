//
//  CacheAssembly.swift
//  chakchat
//
//  Created by лизо4ка курунок on 23.02.2025.
//

import UIKit

// MARK: - CacheAssembly
enum CacheAssembly {
    
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = CachePresenter()
        let interactor = CacheInteractor(presenter: presenter)
        interactor.onRouteToSettingsMenu = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = CacheViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
