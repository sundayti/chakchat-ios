//
//  SignupContext.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
final class SignupContext {
    
    let keychainManager: KeychainManagerBusinessLogic
    let errorHandler: ErrorHandlerLogic
    var state: AppState
    
    init(keychainManager: KeychainManagerBusinessLogic, state: AppState, errorHandler: ErrorHandlerLogic) {
        self.keychainManager = keychainManager
        self.state = state
        self.errorHandler = errorHandler
    }
}
