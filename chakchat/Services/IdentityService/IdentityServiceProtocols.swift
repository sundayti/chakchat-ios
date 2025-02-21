//
//  IdentityServiceProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 19.02.2025.
//

import Foundation

protocol IdentityServiceProtocol {
    func sendCodeRequest<Request: Codable, Response: Codable>(
        _ request: Request,
        _ endpoint: String,
        _ responseType: Response.Type,
        completion: @escaping (Result<SuccessResponse<Response>, Error>) -> Void
    )
    
    func sendVerificationRequest<Request: Codable, Response: Codable>(
        _ request: Request,
        _ endpoint: String,
        _ responseType: Response.Type,
        completion: @escaping (Result<SuccessResponse<Response>, Error>) -> Void
    )
    
    func sendSignupRequest(_ request: SignupModels.SignupRequest,
                           completion: @escaping (Result<SuccessResponse<SuccessModels.Tokens>, Error>) -> Void)
    
    func sendRefreshTokensRequest(_ request: RefreshRequest, 
                                  completion: @escaping (Result<SuccessResponse<SuccessModels.Tokens>, Error>) -> Void)
    
    func sendSignoutRequest(_ request: RefreshRequest, _ accessToken: String, 
                            completion: @escaping (Result<SuccessResponse<SuccessModels.EmptyResponse>, Error>) -> Void)
}
