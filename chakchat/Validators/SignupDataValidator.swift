//
//  SignupValidator.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation

// MARK: - SignupDataValidator
final class SignupDataValidator: SignupValidator {
    
    // MARK: - Name Validation
    func validateName(_ value: String) -> Bool {
        let verificationNameRegex = "^.{1,50}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", verificationNameRegex)
        return predicate.evaluate(with: value)
    }
    
    // MARK: - Username Validation
    func validateUsername(_ value: String) -> Bool {
        let verificationUsernameRegex = "^[a-z][_a-z0-9]{2,19}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", verificationUsernameRegex)
        return predicate.evaluate(with: value)
    }
}
