//
//  VerifyProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation

// MARK: - VerifyBusinessLogic
protocol VerifyBusinessLogic {
    func sendVerificationRequest(_ code: String)
    func routeToSignupScreen(_ state: AppState)
    func routeToChatScreen(_ state: AppState)
    func routeToSendCodeScreen(_ state: AppState)
}

// MARK: - VerifyPresentationLogic
protocol VerifyPresentationLogic {
    func showError(_ error: ErrorId)
}

// MARK: - VerifyWorkerLogic
protocol VerifyWorkerLogic {
    func sendVerificationRequest<Request: Codable, Response: Codable>(
        _ request: Request,
        _ endpoint: String,
        _ responseType: Response.Type,
        completion: @escaping (Result<AppState, Error>) -> Void
    )
    func getVerifyCode(_ key: String) -> UUID?
}
