//
//  UserServiceEndpoints.swift
//  chakchat
//
//  Created by Кирилл Исаев on 12.02.2025.
//

import Foundation
/// если на конце ручки стоит / => нужно будет дописывать
/// {parameter} после этого слеша
enum UserServiceEndpoints: String {
    case me = "/api/user/v1.0/me"
    case meRestrictions = "/api/user/v1.0/me/restrictions"
    case photo = "/api/user/v1.0/me/profile-photo"
    case users = "/api/user/v1.0/users"
    case user = "/api/user/v1.0/user/"
    case username = "api/user/v1.0/user/username/"
    case deletion = "api/user/v1.0/me/deletion/request-code"
    case teapot = "api/user/v1.0/are-you-a-real-teapot"
}
