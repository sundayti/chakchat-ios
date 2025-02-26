//
//  SecretPersonalChatServiceProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 26.02.2025.
//

import Foundation

protocol SecretPersonalChatServiceProtocol {
    func sendCreateChatRequest(
        _ request: ChatsModels.PersonalChat.CreateRequest,
        _ accessToken: String,
        completion: @escaping (Result<SuccessResponse<ChatsModels.SecretPersonalChat.Response>, Error>) -> Void
    )
    
    func sendSetExpirationRequest(
        _ request: ChatsModels.SecretPersonalChat.ExpirationRequest,
        _ chatID: UUID,
        _ accessToken: String,
        completion: @escaping (Result<SuccessResponse<ChatsModels.SecretPersonalChat.Response>, Error>) -> Void
    )
    
    func sendDeleteChatRequest(
        _ chatID: UUID,
        _ deleteMode: DeleteMode,
        _ accessToken: String,
        completion: @escaping (Result<SuccessResponse<EmptyResponse>, Error>) -> Void
    )
}
