//
//  Error+Message.swift
//  chakchat
//
//  Created by Людмила Хромова on 17.01.2025.
//

import Foundation

public extension Error {
    var getErrorMessage: String {
        if self is APIError {
            return "Server error. Please send us an email with the error details to chakkchatt@yandex.ru"
        }

        if let urlError = self as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return "No Internet connection. Try later."
            case .timedOut:
                return "The wait time has expired. Try again."
            default:
                return "Unknown error. Please send us an email with the error details to chakkchatt@yandex.ru"
            }
        }

        return "Unknown error. Please send us an email with the error details to chakkchatt@yandex.ru"
    }
}
