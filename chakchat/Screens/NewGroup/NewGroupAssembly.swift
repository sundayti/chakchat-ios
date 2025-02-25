//
//  NewGroupAssembly.swift
//  chakchat
//
//  Created by лизо4ка курунок on 25.02.2025.
//

import UIKit

// MARK: - NewGroupAssembly
enum NewGroupAssembly {
    
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = NewGroupPresenter()
        let userService = UserService()
        let worker = NewGroupWorker(userService: userService, keychainManager: context.keychainManager)
        let interactor = NewGroupInteractor(presenter: presenter, worker: worker, errorHandler: context.errorHandler)
        interactor.onRouteToNewMessageScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = NewGroupViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

