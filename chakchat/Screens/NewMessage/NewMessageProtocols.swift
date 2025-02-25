//
//  NewMessageProtocols.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import Foundation

// MARK: - NewMessageBusinessLogic
protocol NewMessageBusinessLogic: SearchInteractor {
    func backToChatsScreen()
}

// MARK: - NewMessagePresentationLogic
protocol NewMessagePresentationLogic {
}

// MARK: - NewMessageWorkerLogic
protocol NewMessageWorkerLogic {
    func fetchUsers(
        _ name: String?,
        _ username: String?,
        _ page: Int,
        _ limit: Int,
        completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void
    )
}
