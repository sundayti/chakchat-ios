//
//  ChatProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import Foundation

// MARK: - ChatBusinessLogic
protocol ChatBusinessLogic: AnyObject {
    func routeBack()
    func createChat(_ memberID: UUID)
    func passUserData()
    func sendTextMessage(_ message: String)
}

// MARK: - ChatPresentationLogic
protocol ChatPresentationLogic {
    func passUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}

// MARK: - ChatWorkerLogic
protocol ChatWorkerLogic {
    func createChat(_ memberID: UUID, completion: @escaping (Result<ChatsModels.PersonalChat.Response, Error>) -> Void)
    func sendTextMessage(_ message: String)
}
