//
//  UsersSearchInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.02.2025.
//

import Foundation
import OSLog

final class UsersSearchInteractor: UsersSearchBusinessLogic {
    private let presenter: UsersSearchPresentationLogic
    private let worker: UsersSearchWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    
    init(presenter: UsersSearchPresentationLogic,
         worker: UsersSearchWorkerLogic,
         errorHandler: ErrorHandlerLogic,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.errorHandler = errorHandler
        self.logger = logger
    }
    
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int) {
        worker.fetchUsers(name, username, page, limit) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                os_log("Get users from server", log: logger, type: .info)
                self.showUsers(users)
            case .failure(let failure):
                os_log("Don't get users from server", log: logger, type: .error)
                _ = self.errorHandler.handleError(failure)
            }
        }
    }
    
    func showUsers(_ users: ProfileSettingsModels.Users) {
        presenter.showUsers(users)
    }
}
