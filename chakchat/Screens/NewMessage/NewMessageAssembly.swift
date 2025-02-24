//
//  NewMessageAssembly.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import UIKit

// MARK: - NewMessageAssembly
enum NewMessageAssembly {
    
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = NewMessagePresenter()
        let interactor = NewMessageInteractor(presenter: presenter)
        interactor.onRouteToChatsScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = NewMessageViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
