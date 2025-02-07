//
//  Colors.swift
//  chakchat
//
//  Created by лизо4ка курунок on 22.01.2025.
//

import Foundation
import UIKit

// MARK: - Colors
enum Colors {
    // Used in Start Screen, as ErrorLabel color.
    static let orange: UIColor = UIColor(hex: "FF6200") ?? UIColor.orange
    // Used in Start Screen.
    static let yellow: UIColor = UIColor(hex: "FFBF00") ?? UIColor.yellow
    // Used in Verify Screen as links color.
    static let darkYellow: UIColor = UIColor(hex: "#FFAE00") ?? UIColor.systemYellow
    // Used as fields border color.
    static let gray: UIColor = UIColor(hex: "#383838") ?? UIColor.gray
    // Used in settings.
    static let lightOrange: UIColor = UIColor(hex: "FF9D00") ?? UIColor.orange
    // Used when alerts showing
    static let blackout: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
}
