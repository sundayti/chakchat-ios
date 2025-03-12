//
//  NewGroupProtocols.swift
//  chakchat
//
//  Created by лизо4ка курунок on 25.02.2025.
//

import Foundation

// MARK: - NewGroupProtocols
protocol NewGroupBusinessLogic: SearchInteractor {
    func backToNewMessageScreen()
    func routeToGroupChat(_ chatData: ChatsModels.GeneralChatModel.ChatData)
    func createGroupChat(_ name: String, _ description: String?, _ members: [UUID])
}

protocol NewGroupPresentationLogic {
}

protocol NewGroupWorkerLogic {
    func fetchUsers(
        _ name: String?,
        _ username: String?,
        _ page: Int,
        _ limit: Int,
        completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void
    )
    func createGroupChat(_ name: String, _ description: String?, _ members: [UUID], completion: @escaping (Result<ChatsModels.GeneralChatModel.ChatData, Error>) -> Void)
}
