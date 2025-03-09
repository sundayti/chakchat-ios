//
//  UIBirthDateButton.swift
//  chakchat
//
//  Created by лизо4ка курунок on 06.02.2025.
//

import UIKit

// MARK: - UIDateButton
final class UIDateButton : UIView {
    
    // MARK: - Constants
    private enum Constants {
        static let buttonTitle: String = "Choose"
        static let titleText: String = "Date of Birth"
        static let datePickerTitle: String = "Date of Birth"
        static let titleTop: CGFloat = 7
        static let leading: CGFloat = 0
        static let buttonTop: CGFloat = 2
        static let buttonTrailing: CGFloat = 0
        static let buttonBottom: CGFloat = 0
        
    }
    
    // MARK: - Properties
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.buttonTitle, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.titleLabel?.font = Fonts.systemM17
        return button
    }()
    
    private let titleLabel: UILabel = UILabel()
    private var birthDate: Date = Date()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - Configuration
    private func configure() {
        configureTitleLabel()
        configureButton()
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = Constants.titleText
        titleLabel.font = Fonts.systemL14
        titleLabel.textColor = UIColor.lightGray
        
        titleLabel.pinTop(self.topAnchor, Constants.titleTop)
        titleLabel.pinLeft(self.leadingAnchor, Constants.leading)
    }

    private func configureButton() {
        addSubview(button)
        button.contentHorizontalAlignment = .left        
        button.pinTop(titleLabel.bottomAnchor, Constants.buttonTop)
        button.pinLeft(self.leadingAnchor, Constants.leading)
        button.pinRight(self.trailingAnchor, Constants.buttonTrailing)
        button.pinBottom(self.bottomAnchor, Constants.buttonBottom)
    }
}
