//
//  UserProfileProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import Foundation

// MARK: - UserProfileProtocols
protocol UserProfileBusinessLogic {
    func routeToChat(_ isChatExisting: ChatsModels.GeneralChatModel.ChatData?)
    func searchForExistingChat()
    func createSecretChat()
    
    func blockChat()
    func unblockChat()
    
    func deleteChat(_ deleteMode: DeleteMode)
    
    func switchNotification()
    func passUserData()
    func searchMessages()
    func routeBack()
}

protocol UserProfilePresentationLogic {
    func passUserData(_ userData: ProfileSettingsModels.ProfileUserData, _ profileConfiguration: ProfileConfiguration)
}

protocol UserProfileWorkerLogic {
    func searchMessages()
    func switchNotification()
    func createSecretChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.GeneralChatModel.ChatData, Error>) -> Void)
    
    func blockChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.GeneralChatModel.ChatData, Error>) -> Void)
    func unblockChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.GeneralChatModel.ChatData, Error>) -> Void)
    
    func deleteChat(_ memberID: UUID, _ deleteMode: DeleteMode, completion: @escaping (Result<EmptyResponse, Error>) -> Void)
    
    func searchForExistingChat(_ memberID: UUID) -> Chat?
    func getMyID() -> UUID
}
