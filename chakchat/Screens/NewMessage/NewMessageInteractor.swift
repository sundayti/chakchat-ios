//
//  NewMessageInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import Foundation

// MARK: - NewMessageInteractor
final class NewMessageInteractor: NewMessageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: NewMessagePresentationLogic
    private let worker: NewMessageWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    var onRouteToChatsScreen: (() -> Void)?
    var onRouteToNewMessageScreen: (() -> Void)?
    var onRouteToUser: ((ProfileSettingsModels.ProfileUserData) -> Void)?
    
    // MARK: - Initialization
    init(
        presenter: NewMessagePresentationLogic,
        worker: NewMessageWorkerLogic,
        errorHandler: ErrorHandlerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
        self.errorHandler = errorHandler
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
    
    func routeToUser(_ userData: ProfileSettingsModels.ProfileUserData) {
        onRouteToUser?(userData)
    }
    
    func handleError(_ error: Error) {
        _ = errorHandler.handleError(error)
    }
    
    // MARK: - Routing
    func backToChatsScreen() {
        onRouteToChatsScreen?()
    }
    
    func newGroupRoute() {
        onRouteToNewMessageScreen?()
    }
}

