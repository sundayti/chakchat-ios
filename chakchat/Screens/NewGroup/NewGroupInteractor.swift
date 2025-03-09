//
//  NewGroupInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 25.02.2025.
//

import Foundation

// MARK: - NewGroupInteractor
final class NewGroupInteractor: NewGroupBusinessLogic {
    
    // MARK: - Properties
    private let presenter: NewGroupPresentationLogic
    private let worker: NewGroupWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    var onRouteToNewMessageScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: NewGroupPresentationLogic, worker: NewGroupWorkerLogic, errorHandler: ErrorHandlerLogic) {
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
    
    func handleError(_ error: Error) {
        _ = errorHandler.handleError(error)
    }
    
    // MARK: - Routing
    func backToNewMessageScreen() {
        onRouteToNewMessageScreen?()
    }
}


