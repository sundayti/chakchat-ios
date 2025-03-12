//
//  PersonalChatServiceProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 26.02.2025.
//

import Foundation

// MARK: - PersonalChatServiceProtocol
protocol PersonalChatServiceProtocol {
    func sendCreateChatRequest(
        _ request: ChatsModels.PersonalChat.CreateRequest,
        _ accessToken: String,
        completion: @escaping (Result<SuccessResponse<ChatsModels.GeneralChatModel.ChatData>, Error>) -> Void
    )
    
    func sendBlockChatRequest(
        _ chatID: UUID,
        _ accessToken: String,
        completion: @escaping (Result<SuccessResponse<ChatsModels.GeneralChatModel.ChatData>, Error>) -> Void
    )
    
    func sendUnblockRequest(
        _ chatID: UUID,
        _ accessToken: String,
        completion: @escaping (Result<SuccessResponse<ChatsModels.GeneralChatModel.ChatData>, Error>) -> Void
    )
    
    func sendDeleteChatRequest(
        _ chatID: UUID,
        _ deleteMode: DeleteMode,
        _ accessToken: String,
        completion: @escaping (Result<SuccessResponse<EmptyResponse>, Error>) -> Void
    )
}
