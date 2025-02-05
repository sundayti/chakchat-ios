//
//  MainAppContext.swift
//  chakchat
//
//  Created by Кирилл Исаев on 05.02.2025.
//

import Foundation
import OSLog

final class MainAppContext: MainAppContextProtocol {

    var keychainManager: KeychainManagerBusinessLogic
    var errorHandler: ErrorHandlerLogic
    var userDefaultsManager: UserDefaultsManagerProtocol
    var eventManager: (EventPublisherProtocol & EventSubscriberProtocol)
    var state: AppState
    var logger: OSLog
    
    init(keychainManager: KeychainManagerBusinessLogic, errorHandler: ErrorHandlerLogic, userDefaultsManager: UserDefaultsManagerProtocol, eventManager: EventPublisherProtocol & EventSubscriberProtocol, state: AppState, logger: OSLog) {
        self.keychainManager = keychainManager
        self.errorHandler = errorHandler
        self.userDefaultsManager = userDefaultsManager
        self.eventManager = eventManager
        self.state = state
        self.logger = logger
    }
}
