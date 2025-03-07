//
//  UserProfileProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import Foundation

// MARK: - UserProfileBusinessLogic
protocol UserProfileBusinessLogic {
    func routeToChat(_ isChatExisting: Bool)
    func searchForExistingChat()
    
    func blockChat()
    func unblockChat()
    
    func deleteChat(_ deleteMode: DeleteMode)
    
    func switchNotification()
    func passUserData()
    func searchMessages()
    func routeBack()
}

// MARK: - UserProfilePresentationLogic
protocol UserProfilePresentationLogic {
    func passUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}

// MARK: - UserProfileWorkerLogic
protocol UserProfileWorkerLogic {
    func searchMessages()
    func switchNotification()
    
    func blockChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.PersonalChat.Response, Error>) -> Void)
    func unblockChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.PersonalChat.Response, Error>) -> Void)
    
    func deleteChat(_ memberID: UUID, _ deleteMode: DeleteMode, completion: @escaping (Result<EmptyResponse, Error>) -> Void)
    
    func searchForExistingChat(_ memberID: UUID) -> Bool
    func getMyID() -> UUID
}
