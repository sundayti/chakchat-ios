//
//  MockSendCodeService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation

// MARK: - MockSendCodeService
final class MockIdentityService<T>: IdentityServiceProtocol {
    
    var result: Result<T, Error>?
    
    func sendCodeRequest<Request, Response>(_ request: Request, _ endpoint: String, _ responseType: Response.Type, completion: @escaping (Result<SuccessResponse<Response>, any Error>) -> Void) where Request : Decodable, Request : Encodable, Response : Decodable, Response : Encodable {
        if let result = result as? Result<SuccessResponse<Response>, Error> {
            completion(result)
        }
    }
    
    func sendVerificationRequest<Request, Response>(_ request: Request, _ endpoint: String, _ responseType: Response.Type, completion: @escaping (Result<SuccessResponse<Response>, any Error>) -> Void) where Request : Decodable, Request : Encodable, Response : Decodable, Response : Encodable {
        if let result = result as? Result<SuccessResponse<Response>, Error> {
            completion(result)
        }
    }
    
    func sendSignupRequest(_ request: SignupModels.SignupRequest, completion: @escaping (Result<SuccessResponse<SuccessModels.Tokens>, any Error>) -> Void) {
        if let result = result as? Result<SuccessResponse<SuccessModels.Tokens>, Error> {
            completion(result)
        }
    }
    
    func sendRefreshTokensRequest(_ request: RefreshRequest, completion: @escaping (Result<SuccessResponse<SuccessModels.Tokens>, any Error>) -> Void) {
        if let result = result as? Result<SuccessResponse<SuccessModels.Tokens>, Error> {
            completion(result)
        }
    }
    
    func sendSignoutRequest(_ request: RefreshRequest, _ accessToken: String, completion: @escaping (Result<SuccessResponse<SuccessModels.EmptyResponse>, any Error>) -> Void) {
        if let result = result as? Result<SuccessResponse<SuccessModels.EmptyResponse>, Error> {
            completion(result)
        }
    }
}
