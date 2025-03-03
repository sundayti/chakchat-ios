//
//  UserProfileWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit

final class UserProfileWorker: UserProfileWorkerLogic {
    private let keychainManager: KeychainManagerBusinessLogic
    private let messagingService: UpdateServiceProtocol
    
    init(
        keychainManager: KeychainManagerBusinessLogic,
        messagingService: UpdateServiceProtocol
    ) {
        self.keychainManager = keychainManager
        self.messagingService = messagingService
    }
    
    func searchMessages() {
        /// имплементация позже
    }
    
    func switchNotification() {
        /// имплементация позже
    }
}
