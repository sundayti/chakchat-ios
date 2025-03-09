//
//  UINewGroupButton.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import UIKit

// MARK: - UINewGroupButton
final class UINewGroupButton: UIButton {
    
    // MARK: - Constants
    private enum Constants {
        static let symbolName: String = "person.2.circle"
        static let size: CGFloat = 30
        static let padding: CGFloat = 10
        static let radius: CGFloat = 20
    }
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        var configuration = UIButton.Configuration.plain()
        configuration.title = LocalizationManager.shared.localizedString(for: "new_group")
        configuration.baseForegroundColor = Colors.text
        configuration.image = UIImage(systemName: Constants.symbolName, withConfiguration: UIImage.SymbolConfiguration(pointSize: Constants.size, weight: .light, scale: .default))?.withTintColor(Colors.lightOrange, renderingMode: .alwaysOriginal)
        configuration.imagePadding = Constants.padding
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        configuration.titlePadding = Constants.padding
        configuration.imagePlacement = .leading
        
        self.configuration = configuration
        
        layer.cornerRadius = Constants.radius
        contentHorizontalAlignment = .left
        isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK: - Title Setting
    func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
}
