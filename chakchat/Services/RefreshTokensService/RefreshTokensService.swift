//
//  RefreshTokensService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 14.01.2025.
//

import Foundation
import UIKit
final class RefreshTokensService: RefreshTokensServiceLogic {
    
    func sendRefreshTokensRequest(_ request: Refresh.RefreshRequest, 
                                  completion: @escaping (Result<SuccessModels.Tokens, any Error>) -> Void) {
        
        Sender.send(requestBody: request,
                    responseType: SuccessModels.Tokens.self,
                    endpoint: SigninEndpoints.refreshEndpoint.rawValue,
                    completion: completion)
    }
    
}

enum Refresh {
    
    struct RefreshRequest: Codable {
        let refreshToken: String
        
        enum CodingKeys: String, CodingKey {
            case refreshToken = "refresh_token"
        }
    }
    
}
