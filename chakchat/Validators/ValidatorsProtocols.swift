//
//  ValidatorsProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation

// MARK: - SendCodeValidator
protocol SendCodeValidator {
    func validate(_ value: String) -> Bool
}

// MARK: - VerificationValidator
protocol VerificationValidator {
    func validate(_ value: String) -> Bool
}

// MARK: - SignupValidator
protocol SignupValidator {
    func validateName(_ value: String) -> Bool
    func validateUsername(_ value: String) -> Bool
}
