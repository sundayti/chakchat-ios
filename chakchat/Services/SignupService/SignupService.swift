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
        let endpoint = SignupEndpoints.signupEndpoint.rawValue
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
}
