//
//  StateMachine.swift
//  chakchat
//
//  Created by Кирилл Исаев on 11.01.2025.
//

import Foundation

enum SignupState {
    case sendPhoneCode
    case signupVerifyCode
    case signup
    case signin
    case onChatsMenu
    case _default
}

enum AppState {
    // implemented soon
    case _default
}

