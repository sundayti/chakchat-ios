//
//  IdentityService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 19.02.2025.
//

import UIKit

final class IdentityService: IdentityServiceProtocol {

    func sendCodeRequest<Request, Response>(_ request: Request, _ endpoint: String, _ responseType: Response.Type, completion: @escaping (Result<Response, any Error>) -> Void) where Request : Decodable, Request : Encodable, Response : Decodable, Response : Encodable {
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
    func sendVerificationRequest<Request, Response>(_ request: Request, _ endpoint: String, _ responseType: Response.Type, completion: @escaping (Result<Response, any Error>) -> Void) where Request : Decodable, Request : Encodable, Response : Decodable, Response : Encodable {
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
    func sendSignupRequest(_ request: SignupModels.SignupRequest, completion: @escaping (Result<SuccessModels.Tokens, any Error>) -> Void) {
        let endpoint = IdentityServiceEndpoints.signupEndpoint.rawValue
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
    func sendRefreshTokensRequest(_ request: RefreshRequest, completion: @escaping (Result<SuccessModels.Tokens, any Error>) -> Void) {
        let endpoint = IdentityServiceEndpoints.refreshEndpoint.rawValue
        let idempotencyKey = UUID().uuidString
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Idempotency-Key": idempotencyKey,
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .post, headers: headers, body: body, completion: completion)
    }
    
    func sendSignoutRequest(_ request: RefreshRequest, _ accessToken: String, completion: @escaping (Result<SuccessModels.EmptyResponse, any Error>) -> Void) {
        let endpoint = IdentityServiceEndpoints.signoutEndpoint.rawValue
        
        let body = try? JSONEncoder().encode(request)
        
        let headers = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        Sender.send(endpoint: endpoint, method: .put, headers: headers, body: body, completion: completion)
    }
}

/// используем этот реквест также для signout запроса
/// потому что у них одинаковые тела запроса
struct RefreshRequest: Codable {
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case refreshToken = "refresh_token"
    }
}

