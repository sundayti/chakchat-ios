//
//  RegistrationService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
 
// MARK: - SendCodeService
final class SendCodeService: SendCodeServiceLogic {
    
    func sendCodeRequest<Request: Codable, Response: Codable>(
        _ request: Request,
        _ endpoint: String,
        _ responseType: Response.Type,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
}
