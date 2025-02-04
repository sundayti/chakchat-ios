//
//  UICustomTextField.swift
//  chakchat
//
//  Created by лизо4ка курунок on 01.02.2025.
//

import UIKit

// MARK: - UIProfileTextField
final class UIProfileTextField : UIView {
    
    // MARK: - Properties
    private let titleLabel: UILabel = UILabel()
    internal let textField: UITextField = UITextField()
    private let bottomLine: UIView = UIView()
    
    // MARK: - Initialization
    init(title: String, placeholder: String, isEditable: Bool) {
        super.init(frame: .zero)
        configureUI(title: title, placeholder: placeholder, isEditable: isEditable)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Text
    func setText(_ text: String) {
        textField.text = text
    }
    
    // MARK: - Getting Text
    func getText() -> String? {
        return textField.text
    }
    
    // MARK: - UI Configuration
    private func configureUI(title: String, placeholder: String, isEditable: Bool) {
        configureTitleLabel(title: title)
        configureTextField(placeholder: placeholder, isEditable: isEditable)
        configureBottomLine()
    }
    
    // MARK: - Title Label Configuration
    private func configureTitleLabel(title: String) {
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.font = Fonts.systemL14
        titleLabel.pinTop(self.topAnchor, 7)
        titleLabel.pinLeft(self.leadingAnchor, 20)
        titleLabel.textColor = UIColor.lightGray
    }
    
    // MARK: - Text Field Configuration
    private func configureTextField(placeholder: String, isEditable: Bool) {
        addSubview(textField)
        textField.pinTop(titleLabel.bottomAnchor, 2)
        textField.pinLeft(self.leadingAnchor, 20)
        textField.pinRight(self.trailingAnchor, 20)
        textField.placeholder = placeholder
        textField.font = Fonts.systemM17
        textField.isUserInteractionEnabled = isEditable
    }
    
    // MARK: - Bottom Line Configuration
    private func configureBottomLine() {
        addSubview(bottomLine)
        bottomLine.pinLeft(self.leadingAnchor, 20)
        bottomLine.pinRight(self.trailingAnchor, 20)
        bottomLine.pinTop(textField.bottomAnchor, 9)
        bottomLine.pinBottom(self.bottomAnchor, 0)
        
        bottomLine.setHeight(0.5)
        bottomLine.backgroundColor = UIColor.lightGray
    }
}
