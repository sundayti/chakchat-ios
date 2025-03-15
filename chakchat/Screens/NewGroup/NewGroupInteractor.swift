//
//  NewGroupInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 25.02.2025.
//

import Foundation
import OSLog

// MARK: - NewGroupInteractor
final class NewGroupInteractor: NewGroupBusinessLogic {
        
    // MARK: - Properties
    private let presenter: NewGroupPresentationLogic
    private let worker: NewGroupWorkerLogic
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    var onRouteToGroupChat: ((ChatsModels.GeneralChatModel.ChatData) -> Void)?
    var onRouteToNewMessageScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(
        presenter: NewGroupPresentationLogic,
        worker: NewGroupWorkerLogic,
        logger: OSLog,
        errorHandler: ErrorHandlerLogic
    ) {
        self.presenter = presenter
        self.worker = worker
        self.logger = logger
        self.errorHandler = errorHandler
    }
    
    func createGroupChat(_ name: String, _ description: String?, _ members: [UUID]) {
        worker.createGroupChat(name, description, members) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.routeToGroupChat(data)
                case .failure(let failure):
                    _ = self.errorHandler.handleError(failure)
                    os_log("Failed to create group chat", log: self.logger, type: .fault)
                    print(failure)
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
    }
    // MARK: - Routing
    func routeToGroupChat(_ chatData: ChatsModels.GeneralChatModel.ChatData) {
        onRouteToGroupChat?(chatData)
    }
    
    func backToNewMessageScreen() {
        onRouteToNewMessageScreen?()
    }
}


