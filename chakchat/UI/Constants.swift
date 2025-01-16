//
//  Constants.swift
//  chakchat
//
//  Created by Кирилл Исаев on 15.01.2025.
//

import Foundation
import UIKit

// MARK: - UIConstants
enum UIConstants {
    //MARK: - UIChakChatStackView constants
    static let chakchatStackViewTopAnchor: CGFloat = 20
    static let chakLabelText: String = "Chak"
    static let chatLabelText: String = "Chat"
    static let chakchatFont: UIFont = UIFont(name: "RammettoOne-Regular", size: 80)!
    static let chakchatStackViewSpacing: CGFloat = -50
    
    //MARK: - UIGradientButton constants
    static let gradientButtonTopAnchor: CGFloat = 30
    static let gradientButtonGradientColor: [CGColor] = [
        UIColor(hex: "FF6200")?.cgColor ?? UIColor.yellow.cgColor,
        UIColor(hex: "FFD426")?.cgColor ?? UIColor.orange.cgColor
    ]
    static let gradientButtonGradientStartPoint: CGPoint = CGPoint(x: 0.0, y: 2)
    static let gradientButtonGradientEndPoint: CGPoint = CGPoint(x: -1, y: 0.5)
    static let gradientButtonGradientCornerRadius: CGFloat = 21
}
