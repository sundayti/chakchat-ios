//
//  SuccessModels.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation

// MARK: - SuccessModels
enum SuccessModels {
    
    // MARK: - Tokens Models
    struct Tokens: Codable {
        let accessToken: String
        let refreshToken: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case refreshToken = "refresh_token"
        }
    }
    
    // MARK: - VerifySignupData Models
    struct VerifySignupData: Codable {}
    
    // MARK: - SendCodeSigninData Models
    struct SendCodeSigninData: Codable {
        let signinKey: UUID
        
        enum CodingKeys: String, CodingKey {
            case signinKey = "signin_key"
        }
    }
    
    // MARK: - SendCodeSignupData Models
    struct SendCodeSignupData: Codable {
        let signupKey: UUID
        
        enum CodingKeys: String, CodingKey {
            case signupKey = "signup_key"
        }
    }
}
