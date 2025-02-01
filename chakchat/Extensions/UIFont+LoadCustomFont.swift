//
//  UIFont+LoadCustomFont.swift
//  chakchat
//
//  Created by лизо4ка курунок on 22.01.2025.
//

import UIKit

// MARK: - UIFont Extension
extension UIFont {
    
    // MARK: - Loading Custom Font
    static func loadCustomFont(name: String, size: CGFloat) -> UIFont {
        let fallbackFont = UIFont.systemFont(ofSize: size)
        guard let customFont = UIFont(name: name, size: size) else {
            print("Failed to load custom font '\(name)'. Using fallback font.")
            return fallbackFont
        }
        return customFont
    }
}
