//
//  GroupChatProfileWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

final class GroupChatProfileWorker: GroupChatProfileWorkerLogic {
    private let keychainManager: KeychainManagerBusinessLogic
    
    init(keychainManager: KeychainManagerBusinessLogic) {
        self.keychainManager = keychainManager
    }
}
