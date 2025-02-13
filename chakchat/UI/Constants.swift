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
    
    // MARK: - UIChakChatStackView constants
    static let chakchatStackViewTopAnchor: CGFloat = 40
    static let chakLabelText: String = "Chak"
    static let chatLabelText: String = "Chat"
    static let chakchatFont: UIFont = UIFont.loadCustomFont(name: "RammettoOne-Regular", size: 80)
    static let chakchatStackViewSpacing: CGFloat = -50
    
    // MARK: - UIGradientButton constants
    static let gradientButtonTopAnchor: CGFloat = 30
    static let gradientButtonGradientColor: [CGColor] = [
        Colors.orange.cgColor,
        Colors.yellow.cgColor
    ]
    static let gradientButtonGradientStartPoint: CGPoint = CGPoint(x: 0.0, y: 2)
    static let gradientButtonGradientEndPoint: CGPoint = CGPoint(x: -1, y: 0.5)
    static let gradientButtonGradientCornerRadius: CGFloat = 18
    
    // MARK: - Animation constants
    static let buttonScale: CGFloat = 0.95
    static let animationDuration: TimeInterval = 0.1
    static let buttonAlphaOnPress: CGFloat = 0.8
    static let buttonAlphaOnRelease: CGFloat = 1.0
    
    // MARK: - UIErrorLabel
    static let errorLabelFontSize: CGFloat = 18
    static let errorLabelNumberOfLines: Int = 2
    static let errorLabelMaxWidth: CGFloat = 320
    static let errorDuration: TimeInterval = 0.5
    static let errorMessageDuration: TimeInterval = 2
    static let alphaStart: CGFloat = 0
    static let alphaEnd: CGFloat = 1
    
    // MARK: - Confientiality Settings
    static let ConfidentialitySpaceBetweenSections: CGFloat = 40
    
    // MARK: - Common
    static let dateFormat: String = "dd.MM.yyyy"
}
