//
//  RegistrationViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit

// MARK: - SendCodeViewController
final class SendCodeViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let inputNumberLabelFontSize: CGFloat = 16
        static let inputNumberLabelTopAnchor: CGFloat = 100
        
        static let inputNumberTextFieldTopAnchor: CGFloat = 50
        
        static let descriptionLabelText: String = "by continuing, you agree to our"
        static let descriptionLabelFontSize: CGFloat = 18
        static let descriptionLabelTop: CGFloat = 0
        
        static let linksText: String = "term of service  privacy policy  content policies"
        static let linksFontSize: CGFloat = 15
        static let linksTextTop: CGFloat = 4
        static let linksTextBottom: CGFloat = 0
        
        static let linkTermAddress: String = "terms://"
        static let linkTermLocation: Int = 0
        static let linkTermLenght: Int = 15
        static let linkPrivacyAddress: String = "privacy://"
        static let linkPrivacyLocation: Int = 17
        static let linkPrivacyLenght: Int = 14
        static let linkContentAddress: String = "content://"
        static let linkContentLocation: Int = 33
        static let linkContentLenght: Int = 16
        
        static let policyLabelFont: UIFont = UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        
        static let policyStackViewSpacing: CGFloat = 5
        static let policyStackViewTopAnchor: CGFloat = 5
        
        static let inputButtonHeight: CGFloat = 48
        static let inputButtonWidth: CGFloat = 205
        static let inputButtonFont: UIFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        static let disclaimerLeading: CGFloat = 20
        static let disclaimerTrailing: CGFloat = 20
        static let disclaimerBottom: CGFloat = 10
        
        static let disablingCharactersAmount: Int = 4
        static let numberKerning: CGFloat = 2
        
        static let shortNumberLabelText: String = "Please enter a valid phone number"
        static let shortNumberLabelTop: CGFloat = 360
        static let shortNumberDuration: TimeInterval = 0.5
        
        static let numberOfLines: Int = 2
        static let maxWidth: CGFloat = 320
        static let errorLabelTop: CGFloat = 0
    }
    
    // MARK: - Properties
    private var interactor: SendCodeBusinessLogic
    private lazy var chakchatStackView: UIChakChatStackView = UIChakChatStackView()
    private lazy var inputNumberTextField: UIPhoneNumberTextField = UIPhoneNumberTextField()
    private lazy var sendGradientButton: UIGradientButton = UIGradientButton(title: "Enter")
    private lazy var shortNumberLabel: UILabel = UILabel()
    private lazy var disclaimerView: UIView = UIView()
    private lazy var descriptionLabel: UILabel = UILabel()
    private lazy var linksTextView: UITextView = UITextView()
    private lazy var errorLabel: UIErrorLabel = UIErrorLabel(width: Constants.maxWidth, numberOfLines: Constants.numberOfLines)
    
    private var isPhoneNubmerInputValid: Bool = false
    
    // MARK: - Lifecycle
    init(interactor: SendCodeBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Show Error as label
    func showError(_ message: String?) {
        if message != nil {
            errorLabel.showError(message)
        }
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .white
        
        // I can tap everywhere for didEndEditing
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        overrideUserInterfaceStyle = .light
        
        self.navigationItem.hidesBackButton = true
        
        configureChakChatStackView()
        configureInputNumberTextField()
        configureInputButton()
        configureDisclaimerView()
        configurateErrorLabel()
    }
    
    // MARK: - ChakChat Stack View Configuration
    private func configureChakChatStackView() {
        view.addSubview(chakchatStackView)
        chakchatStackView.pinTop(view.safeAreaLayoutGuide.topAnchor, UIConstants.chakchatStackViewTopAnchor)
        chakchatStackView.pinCenterX(view)
    }
    
    // MARK: - Input Number Text Field Configuration
    private func configureInputNumberTextField() {
        view.addSubview(inputNumberTextField)
        inputNumberTextField.pinTop(chakchatStackView.bottomAnchor, Constants.inputNumberTextFieldTopAnchor)
        inputNumberTextField.pinCenterX(view)
        inputNumberTextField.delegate = self
    }
    
    // MARK: - Input Button Configuration
    private func configureInputButton() {
        view.addSubview(sendGradientButton)
        sendGradientButton.pinCenterX(view)
        sendGradientButton.pinTop(inputNumberTextField.bottomAnchor, UIConstants.gradientButtonTopAnchor)
        sendGradientButton.setHeight(Constants.inputButtonHeight)
        sendGradientButton.setWidth(Constants.inputButtonWidth)
        sendGradientButton.titleLabel?.font = Constants.inputButtonFont
        sendGradientButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
        
    // MARK: - Disclaimer View Configuration
    private func configureDisclaimerView() {
        view.addSubview(disclaimerView)
        disclaimerView.addSubview(descriptionLabel)
        
        descriptionLabel.text = Constants.descriptionLabelText
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionLabelFontSize)

        linksTextView.isEditable = false
        linksTextView.isScrollEnabled = false
        linksTextView.backgroundColor = .clear
        
        let attributedString = NSMutableAttributedString(
            string: Constants.linksText,
            attributes: [
                .font: UIFont.systemFont(ofSize: Constants.linksFontSize),
                .foregroundColor: UIColor.gray,
            ]
        )
        
        // in value property we have to put link
        attributedString.addAttribute(.link,
                value: Constants.linkTermAddress,
                range: NSRange(
                    location: Constants.linkTermLocation,
                    length: Constants.linkTermLenght
                )
            )
        attributedString.addAttribute(.link,
                value: Constants.linkPrivacyAddress,
                range: NSRange(
                    location: Constants.linkPrivacyLocation,
                    length: Constants.linkPrivacyLenght
                )
            )
        attributedString.addAttribute(.link,
                value: Constants.linkContentAddress,
                range: NSRange(
                    location: Constants.linkContentLocation,
                    length: Constants.linkContentLenght
                )
            )
        
        linksTextView.attributedText = attributedString
        linksTextView.linkTextAttributes = [
            .foregroundColor: Colors.darkYellow,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        linksTextView.translatesAutoresizingMaskIntoConstraints = false
        disclaimerView.addSubview(linksTextView)
        
        disclaimerView.pinLeft(view.leadingAnchor, Constants.disclaimerLeading)
        disclaimerView.pinRight(view.trailingAnchor, Constants.disclaimerTrailing)
        disclaimerView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, Constants.disclaimerBottom)
        
        descriptionLabel.pinTop(disclaimerView.topAnchor, Constants.descriptionLabelTop)
        descriptionLabel.pinCenterX(disclaimerView)
        
        linksTextView.pinTop(descriptionLabel.bottomAnchor, Constants.linksTextTop)
        linksTextView.pinCenterX(disclaimerView)
        linksTextView.pinBottom(disclaimerView.bottomAnchor, Constants.linksTextBottom)
    }
    
    // MARK: - Error Label Configuration
    private func configurateErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.pinCenterX(view)
        errorLabel.pinTop(chakchatStackView.bottomAnchor, Constants.errorLabelTop)
    }

    // MARK: - TextField Handling
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch(textField) {
        case inputNumberTextField:
            let validator = PhoneValidator()
            isPhoneNubmerInputValid = validator.validate(text)
        default:
            break
        }
    }

    // MARK: - Actions
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func sendButtonPressed() {
        UIView.animate(withDuration: UIConstants.animationDuration, animations: {
            self.sendGradientButton.transform = CGAffineTransform(scaleX: UIConstants.buttonScale, y: UIConstants.buttonScale)
            }, completion: { _ in
            UIView.animate(withDuration: UIConstants.animationDuration) {
                self.sendGradientButton.transform = CGAffineTransform.identity
            }
        })
        
        guard let phoneText = inputNumberTextField.text else {
            errorLabel.showError(Constants.shortNumberLabelText)
            return
        }
        
        let cleanedPhone = phoneText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if isPhoneNubmerInputValid {
            interactor.sendCodeRequest(
                SendCodeModels.SendCodeRequest(
                    phone: cleanedPhone)
            )
        } else {
            errorLabel.showError(Constants.shortNumberLabelText)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SendCodeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // Получаем текущую позицию курсора
        if let selectedRange = textField.selectedTextRange {
            let cursorOffset = textField.offset(from: textField.beginningOfDocument, to: selectedRange.start)

            // Если курсор находится в диапазоне от 0 до 4, перемещаем его на позицию 4
            if cursorOffset < 4 && selectedRange.isEmpty {
                if let newPosition = textField.position(from: textField.beginningOfDocument, offset: 4) {
                    textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
                }
            }
        }
    }
}
