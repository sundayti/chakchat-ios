//
//  MockSendCodeService.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation

// MARK: - MockSendCodeService
final class MockSendCodeService: SendCodeServiceLogic {
    
    // MARK: - Properties
    var result: Result<SuccessModels.SendCodeSignupData, Error>?
    
    // MARK: - Send Code Request
    func sendCodeRequest<Request, Response>(_ request: Request, _ endpoint: String, _ responseType: Response.Type, completion: @escaping (Result<Response, any Error>) -> Void) where Request : Decodable, Request : Encodable, Response : Decodable, Response : Encodable {
        if let result = result as? Result<Response, Error> {
            completion(result)
        }
    }
    
}
