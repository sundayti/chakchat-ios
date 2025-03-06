//
//  UserProfileWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit

final class UserProfileWorker: UserProfileWorkerLogic {
    private let userDefaultsManager: UserDefaultsManagerProtocol
    private let keychainManager: KeychainManagerBusinessLogic
    private let coreDataManager: CoreDataManagerProtocol
    private let messagingService: UpdateServiceProtocol
    
    init(
        userDefaultsManager: UserDefaultsManagerProtocol,
        keychainManager: KeychainManagerBusinessLogic,
        coreDataManager: CoreDataManagerProtocol,
        messagingService: UpdateServiceProtocol
    ) {
        self.userDefaultsManager = userDefaultsManager
        self.keychainManager = keychainManager
        self.coreDataManager = coreDataManager
        self.messagingService = messagingService
    }
    // return true if chat exists else false
    func searchForExistingChat(_ memberID: UUID) -> Bool {
        let myID = getMyID()
        let chat = coreDataManager.fetchChatByMembers(myID, memberID)
        return chat != nil ? true : false
    }
    
    func getMyID() -> UUID {
        let myID = userDefaultsManager.loadID()
        return myID
    }
    
    func searchMessages() {
        /// имплементация позже
    }
    
    func switchNotification() {
        /// имплементация позже
    }
}
