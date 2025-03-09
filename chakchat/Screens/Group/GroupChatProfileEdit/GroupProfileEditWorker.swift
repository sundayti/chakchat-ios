//
//  GroupProfileEditWorker.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import Foundation

final class GroupProfileEditWorker: GroupProfileEditWorkerLogic {
    private let keychainManager: KeychainManagerBusinessLogic
    private let groupService: GroupChatServiceProtocol
    private let coreDataManager: CoreDataManagerProtocol
    
    init(
        keychainManager: KeychainManagerBusinessLogic,
        groupService: GroupChatServiceProtocol,
        coreDataManager: CoreDataManagerProtocol
    ) {
        self.keychainManager = keychainManager
        self.groupService = groupService
        self.coreDataManager = coreDataManager
    }
}
