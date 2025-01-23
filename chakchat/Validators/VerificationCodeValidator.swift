//
//  VerificationCodeValidator.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation

// MARK: - VerificationCodeValidator
final class VerificationCodeValidator: VerificationValidator {
    func validate(_ value: String) -> Bool {
        let verificationCodeRegex = "^[0-9]{6}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", verificationCodeRegex)
        return predicate.evaluate(with: value)
    }
}
