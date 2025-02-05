//
//  ContextsProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 05.02.2025.
//

import Foundation

protocol CommonContextProtocol: AnyObject {
    var keychainManager: KeychainManagerBusinessLogic { get }
    var errorHandler: ErrorHandlerLogic { get }
    var userDefaultsManager: UserDefaultsManagerProtocol { get }
}

protocol SignupContextProtocol: AnyObject {
    var keychainManager: KeychainManagerBusinessLogic { get }
    var errorHandler: ErrorHandlerLogic { get }
    var userDefaultsManager: UserDefaultsManagerProtocol { get }
    var state: SignupState { get set }
}

protocol MainAppContextProtocol: AnyObject {
    var keychainManager: KeychainManagerBusinessLogic { get }
    var errorHandler: ErrorHandlerLogic { get }
    var userDefaultsManager: UserDefaultsManagerProtocol { get }
    var eventManager: (EventPublisherProtocol & EventSubscriberProtocol) { get }
    var state: AppState { get set }
}

extension SignupContext: CommonContextProtocol {}

extension MainAppContext: CommonContextProtocol {}

