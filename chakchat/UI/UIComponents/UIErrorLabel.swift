//
//  UIErrorLabel.swift
//  chakchat
//
//  Created by лизо4ка курунок on 21.01.2025.
//

import Foundation
import UIKit

// MARK: - UIErrorLabel
final class UIErrorLabel: UILabel {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }
    
    // MARK: - Initialization
    init(width: CGFloat, numberOfLines: Int) {
        super.init(frame: .zero)
        self.setWidth(width)
        self.numberOfLines = numberOfLines
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Show Error as label
    func showError(_ message: String?) {
        self.alpha = UIConstants.alphaStart
        self.isHidden = false
        self.text = message
        
        // Slowly increase alpha to 1 for full visibility.
        UIView.animate(withDuration: UIConstants.errorDuration, animations: {
            self.self.alpha = UIConstants.alphaEnd
        })

        // Hide label with animation
        DispatchQueue.main.asyncAfter(deadline: .now() + UIConstants.errorMessageDuration) {
            UIView.animate(withDuration: UIConstants.errorDuration, animations: {
                self.self.alpha = UIConstants.alphaStart
            }, completion: { _ in
                self.self.isHidden = true
            })
        }
    }
    
    // MARK: - Common Initialization
    private func commonInit() {
        self.font = UIFont.systemFont(ofSize: UIConstants.errorLabelFontSize)
        self.isHidden = true
        self.textColor = Colors.orange
        self.textAlignment = .center
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = UIConstants.errorLabelNumberOfLines
    }
}
