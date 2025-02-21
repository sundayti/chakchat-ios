//
//  UsersSearchAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.02.2025.
//

import UIKit
import OSLog
enum UsersSearchAssembly {
    static func build(_ keychainManager: KeychainManagerBusinessLogic,
                      _ errorHandler: ErrorHandlerLogic,
                      _ logger: OSLog) -> UIViewController {
        let presenter = UsersSearchPresenter()
        let userService = UserService()
        let worker = UsersSearchWorker(keychainManager: keychainManager, userService: userService)
        let interactor = UsersSearchInteractor(presenter: presenter, worker: worker, errorHandler: errorHandler, logger: logger)
        let view = UsersSearchViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
