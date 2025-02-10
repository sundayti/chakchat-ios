//
//  SignupService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation

// MARK: - SignupService
final class SignupService: SignupServiceLogic {
    
    func sendSignupRequest(_ request: SignupModels.SignupRequest,
                           completion: @escaping (Result<SuccessModels.Tokens, Error>) -> Void) {
        Sender.Post(
            requestBody: request,
            responseType: SuccessModels.Tokens.self,
            endpoint: SignupEndpoints.signupEndpoint.rawValue,
            completion: completion
        )
    }
    
}
