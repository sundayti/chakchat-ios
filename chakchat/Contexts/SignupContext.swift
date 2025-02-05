//
//  SignupContext.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import OSLog

// MARK: - SignupContext
final class SignupContext: SignupContextProtocol {
        
    // MARK: - Properties
    let keychainManager: KeychainManagerBusinessLogic
    let errorHandler: ErrorHandlerLogic
    let userDefaultsManager: UserDefaultsManagerProtocol
    var state: SignupState
    var logger: OSLog
    
    // MARK: - Initialization
    init(keychainManager: KeychainManagerBusinessLogic, errorHandler: ErrorHandlerLogic, userDefaultsManager: UserDefaultsManagerProtocol, state: SignupState, logger: OSLog) {
        self.keychainManager = keychainManager
        self.errorHandler = errorHandler
        self.userDefaultsManager = userDefaultsManager
        self.state = state
        self.logger = logger
    }
}

