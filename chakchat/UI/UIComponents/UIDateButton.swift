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
    private let datePicker = UIDatePicker()
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
    
    // MARK: - Title Label Configuration
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = Constants.titleText
        titleLabel.font = Fonts.systemL14
        titleLabel.textColor = UIColor.lightGray
        
        titleLabel.pinTop(self.topAnchor, Constants.titleTop)
        titleLabel.pinLeft(self.leadingAnchor, Constants.leading)
    }
    
    // MARK: - Button Configuration
    private func configureButton() {
        addSubview(button)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(showDatePicker), for: .touchUpInside)
        
        button.pinTop(titleLabel.bottomAnchor, Constants.buttonTop)
        button.pinLeft(self.leadingAnchor, Constants.leading)
        button.pinRight(self.trailingAnchor, Constants.buttonTrailing)
        button.pinBottom(self.bottomAnchor, Constants.buttonBottom)
    }
    
    // MARK: - Actions
    @objc
    private func showDatePicker() {
        guard let viewController = findViewController() else { return }
        
        viewController.askDate(title: Constants.datePickerTitle, settedDate: self.birthDate)
        { [weak self] date in
            guard let self = self else { return }
            if let selectedDate = date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = UIConstants.dateFormat
                self.birthDate = selectedDate
                self.button.setTitle(dateFormatter.string(from: selectedDate), for: .normal)
                self.button.setTitleColor(.black, for: .normal)
            } else {
                self.birthDate = Date()
                self.button.setTitle(Constants.buttonTitle, for: .normal)
                self.button.setTitleColor(UIColor.lightGray, for: .normal)
            }
        }
    }

    // MARK: - Find ViewController
    private func findViewController() -> UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
