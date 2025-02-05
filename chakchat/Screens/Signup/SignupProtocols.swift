//
//  SignupProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation

// MARK: - SignupBusinessLogic
protocol SignupBusinessLogic {
    func sendSignupRequest(_ name: String, _ username: String)
    func successTransition(_ state: SignupState)
}

// MARK: - SignupWorkerLogic
protocol SignupWorkerLogic {
    func sendRequest(_ request: SignupModels.SignupRequest,
                     completion: @escaping (Result<SignupState, Error>) -> Void)
    
    func getSignupCode() -> UUID?
}

// MARK: - SignupPresentationLogic
protocol SignupPresentationLogic {
    func showError(_ error: ErrorId)
}
