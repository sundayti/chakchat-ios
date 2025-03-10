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
    var onRouteToChat: ((ProfileSettingsModels.ProfileUserData, Bool) -> Void)?
    
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
    
    // MARK: - Public Methods
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
    
    func searchForExistingChat(_ userData: ProfileSettingsModels.ProfileUserData) {
        let isChatExisting = worker.searchForExistingChat(userData.id)
        routeToChat(userData, isChatExisting)
    }

    func handleError(_ error: Error) {
        _ = errorHandler.handleError(error)
    }
    
    // MARK: - Routing
    func backToChatsScreen() {
        onRouteToChatsScreen?()
    }
    
    func routeToChat(_ userData: ProfileSettingsModels.ProfileUserData, _ isChatExisting: Bool) {
        onRouteToChat?(userData, false)
    }
    
    func newGroupRoute() {
        onRouteToNewMessageScreen?()
    }
}

