//
//  IdentityServiceEndpoints.swift
//  chakchat
//
//  Created by Кирилл Исаев on 19.02.2025.
//

import Foundation

enum IdentityServiceEndpoints: String {
    
    case signupCodeEndpoint = "/api/identity/v1.0/signup/send-phone-code"
    case verifyCodeEndpoint = "/api/identity/v1.0/signup/verify-code"
    case signupEndpoint = "/api/identity/v1.0/signup"
    case signoutEndpoint = "/api/identity/v1.0/sign-out"
    
    case signinCodeEndpoint = "/api/identity/v1.0/signin/send-phone-code"
    case signinEndpoint = "/api/identity/v1.0/signin"
    case refreshEndpoint = "/api/identity/v1.0/signin/refresh-token"
}
