//
//  SignupProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation

// MARK: - Signup Protocols
protocol SignupBusinessLogic {
    func sendSignupRequest(_ name: String, _ username: String)
    func successTransition(_ state: SignupState)
}

protocol SignupWorkerLogic {
    func sendRequest(_ request: SignupModels.SignupRequest,
                     completion: @escaping (Result<SignupState, Error>) -> Void)
    
    func getSignupCode() -> UUID?
}

protocol SignupPresentationLogic {
    func showError(_ error: ErrorId)
}
