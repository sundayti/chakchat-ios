//
//  ChatsScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit

// MARK: - ChatAssembly
enum ChatsAssembly {
    
    // MARK: - Assembly Method
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = ChatsScreenPresenter()
        let worker = ChatsScreenWorker()
        let interactor = ChatsScreenInteractor(presenter: presenter, worker: worker, logger: context.logger, errorHandler: context.errorHandler, keychainManager: context.keychainManager)
        interactor.onRouteToSettings = { [weak coordinator] in
            coordinator?.showSettingsScreen()
        }
        let view = ChatsScreenViewController(interactor: interactor)
        presenter.view = view
        
        return view
    }
}
