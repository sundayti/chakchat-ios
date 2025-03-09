//
//  NewGroupProtocols.swift
//  chakchat
//
//  Created by лизо4ка курунок on 25.02.2025.
//

import Foundation

// MARK: - NewGroupBusinessLogic
protocol NewGroupBusinessLogic: SearchInteractor {
    func backToNewMessageScreen()
    func routeToGroupChat(_ chatData: ChatsModels.GroupChat.Response)
    func createGroupChat(_ name: String, _ description: String?, _ members: [UUID])
}

// MARK: - NewGroupWorkerLogic
protocol NewGroupPresentationLogic {
}

// MARK: - NewGroupWorkerLogic
protocol NewGroupWorkerLogic {
    func fetchUsers(
        _ name: String?,
        _ username: String?,
        _ page: Int,
        _ limit: Int,
        completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void
    )
    func createGroupChat(_ name: String, _ description: String?, _ members: [UUID], completion: @escaping (Result<ChatsModels.GroupChat.Response, Error>) -> Void)
}
