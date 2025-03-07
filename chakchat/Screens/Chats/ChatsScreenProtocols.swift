//
//  ChatsScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit

// MARK: - ChatsScreenBusinessLogic
protocol ChatsScreenBusinessLogic: SearchInteractor {
    func routeToSettingsScreen()
    func routeToNewMessageScreen()
    func loadChats()
    func handleChatCreatingEvent(_ event: CreatedPersonalChatEvent)
    func addNewChat(_ chatData: ChatsModels.PersonalChat.Response)
    func getUserDataByID(_ users: [UUID], completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
}

// MARK: - ChatsScreenPresentationLogic
protocol ChatsScreenPresentationLogic {
    func addNewChat(_ chatData: ChatsModels.PersonalChat.Response)
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
    func getUserDataByID(_ users: [UUID], completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
}

protocol SearchInteractor {
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void)
    
    func handleError(_ error: Error)
}
