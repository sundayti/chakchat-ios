//
//  SignupEndpoints.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation

// MARK: - SignupEndpoints
enum SignupEndpoints: String {
    case sendPhoneCodeEndpoint = "/api/identity/v1.0/signup/send-phone-code"
    case verifyCodeEndpoint = "/api/identity/v1.0/signup/verify-code"
    case signupEndpoint = "/api/identity/v1.0/signup"
}
