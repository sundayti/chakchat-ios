//
//  ChatsScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit

// MARK: - ChatsScreen Protocols
protocol ChatsScreenBusinessLogic: SearchInteractor {
    func loadMeData()
    func loadMeRestrictions()
    func loadChats()
    
    func showChats(_ allChatsData: ChatsModels.GeneralChatModel.ChatsData)
    func addNewChat(_ chatData: ChatsModels.GeneralChatModel.ChatData)
    
    func routeToSettingsScreen()
    func routeToNewMessageScreen()
    
    func handlePersonalChatCreatingEvent(_ event: CreatedPersonalChatEvent)

    func getUserDataByID(_ users: [UUID], completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
}

protocol ChatsScreenPresentationLogic {
    func addNewChat(_ chatData: ChatsModels.GeneralChatModel.ChatData)
    func showChats(_ allChatsData: ChatsModels.GeneralChatModel.ChatsData)
}

protocol ChatsScreenWorkerLogic {
    func loadMeData(completion: @escaping (Result<Void, Error>) -> Void)
    func loadMeRestrictions(completion: @escaping (Result<Void, Error>) -> Void)
    func loadChats(completion: @escaping (Result<ChatsModels.GeneralChatModel.ChatsData, Error>) -> Void)
    
    func fetchUsers(
        _ name: String?,
        _ username: String?,
        _ page: Int,
        _ limit: Int,
        completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void
    )
    
    func getUserDataByID(_ users: [UUID], completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
}

// MARK: - SearchInteractor Protocol
protocol SearchInteractor {
    func fetchUsers(_ name: String?, _ username: String?, _ page: Int, _ limit: Int, completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void)
    
    func handleError(_ error: Error)
}
