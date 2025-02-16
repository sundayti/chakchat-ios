//
//  RefreshTokensService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 14.01.2025.
//

import Foundation

// MARK: - RefreshTokensService
final class RefreshTokensService: RefreshTokensServiceLogic {
    
    func sendRefreshTokensRequest(_ request: Refresh.RefreshRequest, 
                                  completion: @escaping (Result<SuccessModels.Tokens, any Error>) -> Void) {
        let endpoint = SigninEndpoints.refreshEndpoint.rawValue
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
}

// MARK: - Refresh Models
enum Refresh {
    
    struct RefreshRequest: Codable {
        let refreshToken: String
        
        enum CodingKeys: String, CodingKey {
            case refreshToken = "refresh_token"
        }
    }
    
}
