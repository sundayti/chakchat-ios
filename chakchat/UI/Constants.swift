//
//  Constants.swift
//  chakchat
//
//  Created by Кирилл Исаев on 15.01.2025.
//

import Foundation
import UIKit
enum UIConstants {
    //MARK: - UIChakChatStackView constants
    static let chakchatStackViewTopAnchor: CGFloat = 20
    static let chakLabelText: String = "Chak"
    static let chatLabelText: String = "Chat"
    static let chakchatFont: UIFont = UIFont(name: "RammettoOne-Regular", size: 80)!
    static let chakchatStackViewSpacing: CGFloat = -50
    
    //MARK: - UIGradientButton constants
    static let gradientButtonHeight: CGFloat = 50
    static let gradientButtonWidth: CGFloat = 200
    static let gradientButtonFont: UIFont = UIFont.systemFont(ofSize: 26, weight: .bold)
    static let gradientButtonTopAnchor: CGFloat = 40
    static let gradientButtonGradientColor: [CGColor] = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
    static let gradientButtonGradientStartPoint: CGPoint = CGPoint(x: 0.0, y: 0.5)
    static let gradientButtonGradientEndPoint: CGPoint = CGPoint(x: 1, y: 0.5)
    static let gradientButtonGradientCornerRadius: CGFloat = 25
}
