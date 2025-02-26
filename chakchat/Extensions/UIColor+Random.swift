//
//  UIColor + Random.swift
//  chakchat
//
//  Created by Кирилл Исаев on 25.02.2025.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        let minBrightness: CGFloat = 0.5
        let red = CGFloat.random(in: minBrightness...1)
        let green = CGFloat.random(in: minBrightness...1)
        let blue = CGFloat.random(in: minBrightness...1)
        
        return UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
    }
}
