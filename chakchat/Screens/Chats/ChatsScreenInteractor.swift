//
//  ChatsScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit
import OSLog

// MARK: - ChatsScreenInteractor
final class ChatsScreenInteractor: ChatsScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ChatsScreenPresentationLogic
    private let worker: ChatsScreenWorkerLogic
    private let logger: OSLog
    private let errorHandler: ErrorHandlerLogic
    private let keychainManager: KeychainManagerBusinessLogic
    
    var onRouteToSettings: (() -> Void)?
    var onRouteToNewMessage: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ChatsScreenPresentationLogic, 
         worker: ChatsScreenWorkerLogic,
         logger: OSLog,
         errorHandler: ErrorHandlerLogic, 
         keychainManager: KeychainManagerBusinessLogic
    ) {
        self.presenter = presenter
        self.worker = worker
        self.logger = logger
        self.errorHandler = errorHandler
        self.keychainManager = keychainManager
    }
    
    // MARK: - Routing
    func routeToSettingsScreen() {
        os_log("Routed to settings screen", log: logger, type: .default)
        onRouteToSettings?()
    }
    
    func routeToNewMessageScreen() {
        os_log("Routed to new message screen", log: logger, type: .default)
        onRouteToNewMessage?()
    }
    
    func loadMeData() {
        os_log("Fetching for user data", log: logger, type: .default)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.worker.loadMeData() { result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(_):
                        os_log("Loaded user data", log: self.logger, type: .default)
                        break
                    case .failure(let failure):
                        _ = self.errorHandler.handleError(failure)
                        os_log("Failure in fetching user data:\n", log: self.logger, type: .fault)
                        print(failure)
                    }
                }
            }
        }
    }
    
    func loadMeRestrictions() {
        os_log("Fetching for user restrictions", log: logger, type: .default)
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.worker.loadMeRestrictions { result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(_):
                        os_log("Loaded user restrictions", log: self.logger, type: .default)
                        break
                    case .failure(let failure):
                        _ = self.errorHandler.handleError(failure)
                        os_log("Failure in fetching user restrictions:\n", log: self.logger, type: .fault)
                        print(failure)
                    }
                }
            }
        }
    }
    
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, any Error>) -> Void) {
        worker.fetchUsers(name, username, page, limit) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func handleError(_ error: Error) {
        _ = errorHandler.handleError(error)
        os_log("Failed:\n", log: logger, type: .fault)
        print(error)
    }
}
