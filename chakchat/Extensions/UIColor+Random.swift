//
//  UIColor + Random.swift
//  chakchat
//
//  Created by Кирилл Исаев on 25.02.2025.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(displayP3Red: .random(in: (0...1)),
                       green: .random(in: (0...1)),
                       blue: .random(in: (0...1)),
                       alpha: 1)
    }
}
