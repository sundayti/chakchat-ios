//
//  UserServiceEndpoints.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.02.2025.
//

import Foundation

enum UserServiceEndpoints: String {
    case me = "/api/user/v1.0/me"
    case meRestrictions = "/api/user/v1.0/me/restrictions"
    case users = "/api/user/v1.0/users"
}
