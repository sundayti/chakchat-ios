//
//  VerificationService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation

// MARK: - VerificationService
final class VerificationService: VerificationServiceLogic {
    
    func sendVerificationRequest<Request: Codable, Response: Codable>(
        _ request: Request,
        _ endpoint: String,
        _ responseType: Response.Type,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        Sender.send(
            requestBody: request,
            responseType: responseType,
            endpoint: endpoint,
            completion: completion
        )
    }
    
}
