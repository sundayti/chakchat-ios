//
//  UserProfileProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import Foundation

protocol UserProfileBusinessLogic {
    func routeToChat(_ isChatExisting: Bool)
    func searchForExistingChat()
    
    func switchNotification()
    func passUserData()
    func searchMessages()
    func routeBack()
}

protocol UserProfilePresentationLogic {
    func passUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}

protocol UserProfileWorkerLogic {
    func searchMessages()
    func switchNotification()
    func searchForExistingChat(_ memberID: UUID) -> Bool
    func getMyID() -> UUID
}
