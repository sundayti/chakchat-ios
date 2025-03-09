//
//  RegistrationProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation

// MARK: - SendCodeProtocols
protocol SendCodeBusinessLogic {
    func sendCodeRequest(_ request: SendCodeModels.SendCodeRequest)
    func successTransition(_ state: SignupState)
}

protocol SendCodePresentationLogic {
    func showError(_ error: ErrorId)
}

protocol SendCodeWorkerLogic {
    func sendInRequest(_ request: SendCodeModels.SendCodeRequest,
                     completion: @escaping (Result<SignupState, Error>) -> Void)
    
    func sendUpRequest(_ request: SendCodeModels.SendCodeRequest,
                     completion: @escaping (Result<SignupState, Error>) -> Void)
}
