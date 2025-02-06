//
//  SigninEndpoints.swift
//  chakchat
//
//  Created by Кирилл Исаев on 10.01.2025.
//

import Foundation

// MARK: - SigninEndpoints
enum SigninEndpoints: String {
    case sendPhoneCodeEndpoint = "/api/identity/v1.0/signin/send-phone-code"
    case signinEndpoint = "/api/identity/v1.0/signin"
    case refreshEndpoint = "/api/identity/v1.0/signin/refresh-token"
}
