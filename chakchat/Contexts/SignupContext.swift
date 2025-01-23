//
//  SignupContext.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation

// MARK: - SignupContext
final class SignupContext {
    
    // MARK: - Properties
    let keychainManager: KeychainManagerBusinessLogic
    let errorHandler: ErrorHandlerLogic
    let userDefaultManager: UserDefaultsManager
    var state: AppState
    
    // MARK: - Initialization
    init(keychainManager: KeychainManagerBusinessLogic, errorHandler: ErrorHandlerLogic, userDefaultManager: UserDefaultsManager, state: AppState) {
        self.keychainManager = keychainManager
        self.errorHandler = errorHandler
        self.userDefaultManager = userDefaultManager
        self.state = state
    }
}
