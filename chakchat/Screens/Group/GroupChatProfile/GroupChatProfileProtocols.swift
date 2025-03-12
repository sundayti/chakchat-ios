//
//  GroupChatProfileProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

protocol GroupChatProfileBusinessLogic: SearchInteractor {
    func passChatData()
    
    func deleteGroup()
    func addMember(_ memberID: UUID)
    func deleteMember(_ memberID: UUID)
    
    func getUserDataByID(_ users: [UUID], completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
    
    func routeToChatMenu()
    func routeToEdit()
    func routeBack()
}

protocol GroupChatProfilePresentationLogic {
    func passChatData(_ chatData: ChatsModels.GeneralChatModel.ChatData, _ isAdmin: Bool)
}

protocol GroupChatProfileWorkerLogic {
    func deleteGroup(
        _ chatID: UUID,
        completion: @escaping (Result<EmptyResponse, Error>) -> Void
    )
    func addMember(
        _ chatID: UUID,
        _ memberID: UUID,
        completion: @escaping (Result<ChatsModels.GeneralChatModel.ChatData, Error>) -> Void
    )
    func deleteMember(
        _ chatID: UUID,
        _ memberID: UUID,
        completion: @escaping (Result<ChatsModels.GeneralChatModel.ChatData, Error>) -> Void
    )
    func fetchUsers(
        _ name: String?,
        _ username: String?,
        _ page: Int,
        _ limit: Int,
        completion: @escaping (Result<ProfileSettingsModels.Users, Error>) -> Void
    )
    
    func getUserDataByID(_ users: [UUID], completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
    
    func getMyID() -> UUID
}
