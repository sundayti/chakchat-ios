//
//  MainAppContext.swift
//  chakchat
//
//  Created by Кирилл Исаев on 05.02.2025.
//

import Foundation
import OSLog

final class MainAppContext: MainAppContextProtocol {

    let keychainManager: KeychainManagerBusinessLogic
    let errorHandler: ErrorHandlerLogic
    let userDefaultsManager: UserDefaultsManagerProtocol
    let eventManager: (EventPublisherProtocol & EventSubscriberProtocol)
    let coreDataManager: CoreDataManagerProtocol
    var state: AppState
    let logger: OSLog
    
    init(
        keychainManager: KeychainManagerBusinessLogic,
        errorHandler: ErrorHandlerLogic,
        userDefaultsManager: UserDefaultsManagerProtocol,
        eventManager: EventPublisherProtocol & EventSubscriberProtocol,
        coreDataManager: CoreDataManagerProtocol,
        state: AppState,
        logger: OSLog
    ) {
        self.keychainManager = keychainManager
        self.errorHandler = errorHandler
        self.userDefaultsManager = userDefaultsManager
        self.eventManager = eventManager
        self.coreDataManager = coreDataManager
        self.state = state
        self.logger = logger
    }
}
