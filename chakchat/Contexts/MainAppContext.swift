//
//  MainAppContext.swift
//  chakchat
//
//  Created by Кирилл Исаев on 05.02.2025.
//

import Foundation

final class MainAppContext: MainAppContextProtocol {

    var keychainManager: KeychainManagerBusinessLogic
    var errorHandler: ErrorHandlerLogic
    var userDefaultsManager: UserDefaultsManagerProtocol
    var eventManager: (EventPublisherProtocol & EventSubscriberProtocol)
    var state: AppState
    
    init(keychainManager: KeychainManagerBusinessLogic, errorHandler: ErrorHandlerLogic, userDefaultsManager: UserDefaultsManagerProtocol, eventManager: EventPublisherProtocol & EventSubscriberProtocol, state: AppState) {
        self.keychainManager = keychainManager
        self.errorHandler = errorHandler
        self.userDefaultsManager = userDefaultsManager
        self.eventManager = eventManager
        self.state = state
    }
}
