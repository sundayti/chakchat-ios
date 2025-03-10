//
//  GroupChatProfileProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

protocol GroupChatProfileBusinessLogic {
    func passChatData()
    
    func deleteGroup()
    func addMember(_ memberID: UUID)
    func deleteMember(_ memberID: UUID)
    
    func routeToChatMenu()
    func routeToEdit()
    func routeBack()
}

protocol GroupChatProfilePresentationLogic {
    func passChatData(_ chatData: ChatsModels.GroupChat.Response, _ isAdmin: Bool)
}

protocol GroupChatProfileWorkerLogic {
    func deleteGroup(
        _ chatID: UUID,
        completion: @escaping (Result<EmptyResponse, Error>) -> Void
    )
    func addMember(
        _ chatID: UUID,
        _ memberID: UUID,
        completion: @escaping (Result<ChatsModels.GroupChat.Response, Error>) -> Void
    )
    func deleteMember(
        _ chatID: UUID,
        _ memberID: UUID,
        completion: @escaping (Result<ChatsModels.GroupChat.Response, Error>) -> Void
    )
    func getMyID() -> UUID
}
