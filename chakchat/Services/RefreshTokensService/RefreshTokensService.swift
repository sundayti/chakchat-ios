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
        
        Sender.Post(requestBody: request,
                    responseType: SuccessModels.Tokens.self,
                    endpoint: SigninEndpoints.refreshEndpoint.rawValue,
                    completion: completion)
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
