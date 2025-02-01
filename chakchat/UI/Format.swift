//
//  Format.swift
//  chakchat
//
//  Created by лизо4ка курунок on 31.01.2025.
//

import Foundation

// MARK: - Format
final class Format {
    
    // MARK: - Formatting Raw Number
    static func number(_ number: String) -> String? {
        guard number.count == 11 else {
            print("Incorrect number length")
            return nil
        }
        let formattedNumber = "+7 (\(number.prefix(4).suffix(3))) \(number.prefix(7).suffix(3))-\(number.prefix(9).suffix(2))-\(number.suffix(2))"
        
        return formattedNumber
    }
}
