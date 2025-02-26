//
//  ChatsServiceProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 26.02.2025.
//

import Foundation

protocol ChatsServiceProtocol {
    func sendGetChatsRequest(
        _ accessToken: String,
        completion: @escaping (Result<SuccessResponse<ChatsModels.GeneralChatModel.ChatsData>, Error>) -> Void
    )
    
    func sendGetChatRequest(
        _ chatID: UUID,
        _ accessToken: String,
        completion: @escaping (Result<SuccessResponse<ChatsModels.GeneralChatModel.ChatsData>, Error>) -> Void
    )
}
