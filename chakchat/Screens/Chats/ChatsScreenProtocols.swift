//
//  ChatsScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit

// MARK: - ChatsScreenBusinessLogic
protocol ChatsScreenBusinessLogic {
    func routeToSettingsScreen()
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void)
    func handleError(_ error: Error)
}

// MARK: - ChatsScreenPresentationLogic
protocol ChatsScreenPresentationLogic {
    
}

// MARK: - ChatsScreenWorkerLogic
protocol ChatsScreenWorkerLogic {
    func fetchUsers(
        _ name: String?,
        _ username: String?,
        _ page: Int,
        _ limit: Int,
        completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void
    )
}
