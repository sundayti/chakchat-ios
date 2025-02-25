//
//  UINewGroupButton.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import UIKit

// MARK: - UINewGroupButton
final class UINewGroupButton: UIButton {
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        setTitle(LocalizationManager.shared.localizedString(for: "new_group"), for: .normal)
        setTitleColor(Colors.text, for: .normal)
        layer.cornerRadius = 20
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .light, scale: .default)
        let gearImage = UIImage(systemName: "person.2.circle", withConfiguration: config)
        setImage(gearImage, for: .normal)
        isUserInteractionEnabled = true
        imageView?.tintColor = Colors.lightOrange
        contentHorizontalAlignment = .left
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setTitle(_ title: String) {
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
