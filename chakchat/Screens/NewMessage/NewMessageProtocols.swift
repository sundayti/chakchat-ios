//
//  NewMessageProtocols.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import Foundation

// MARK: - NewMessageProtocols
protocol NewMessageBusinessLogic: SearchInteractor {
    func backToChatsScreen()
    func routeToChat(_ userData: ProfileSettingsModels.ProfileUserData, _ isChatExisting: Bool)
    func newGroupRoute()
    func searchForExistingChat(_ userData: ProfileSettingsModels.ProfileUserData)
}

protocol NewMessagePresentationLogic {
}

protocol NewMessageWorkerLogic {
    func fetchUsers(
        _ name: String?,
        _ username: String?,
        _ page: Int,
        _ limit: Int,
        completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void
    )
    
    func searchForExistingChat(_ memberID: UUID) -> Bool
}
