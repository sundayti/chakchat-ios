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
    internal enum Constants {
        static let inputPhoneFont: UIFont = UIFont(name: "OpenSans-Regular", size: 28)!
        static let inputNumberLabelFontSize: CGFloat = 16
        static let inputNumberLabelTopAnchor: CGFloat = 100
        
        static let inputNumberTextFieldPlaceholder: String = "+7 000 000 0000"
        static let inputNumberTextFieldTopAnchor: CGFloat = 50
        static let inputNumberTextFieldHeight: CGFloat = 60
        static let inputNumberTextFieldWidth: CGFloat = 300
        static let inputNumberTextFieldPaddingWidth: CGFloat = 10
        static let inputNumberTextFieldCornerRadius: CGFloat = 8
        static let inputNumberTextFieldBorderWidth: CGFloat = 1
        static let inputNumberPaddingX: CGFloat = 0
        static let inputNumberPaddingY: CGFloat = 0
        
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
        static let errorMessageDuration: TimeInterval = 2
        static let alphaStart: CGFloat = 0
        static let alphaEnd: CGFloat = 1
        static let shortNumberLabelTop: CGFloat = 360
        static let shortNumberDuration: TimeInterval = 0.5
        
        static let errorLabelFontSize: CGFloat = 18
        static let errorLabelTop: CGFloat = 0
        static let errorDuration: TimeInterval = 0.5
        static let numberOfLines: Int = 2
        static let maxWidth: CGFloat = 320
    }
    
    // MARK: - Fields
    private var interactor: SendCodeBusinessLogic
    private lazy var chakchatStackView: UIChakChatStackView = UIChakChatStackView()
    private lazy var inputNumberTextField: PhoneNumberTextField = PhoneNumberTextField()
    private lazy var sendGradientButton: UIGradientButton = UIGradientButton(title: "Enter")
    private lazy var shortNumberLabel: UILabel = UILabel()
    private lazy var inputFieldColor: UIColor = UIColor(hex: "#383838") ?? UIColor.gray
    private lazy var linksColor: UIColor = UIColor(hex: "#FFAE00") ?? UIColor.systemYellow
    private lazy var errorColor: UIColor = UIColor(hex: "FF6200") ?? UIColor.orange
    private lazy var disclaimerView: UIView = UIView()
    private lazy var descriptionLabel: UILabel = UILabel()
    private lazy var linksTextView: UITextView = UITextView()
    private lazy var errorLabel: UILabel = UILabel()
    
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
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - Show Error as label
    func showError(_ message: String?) {
        view.addSubview(errorLabel)
        errorLabel.alpha = Constants.alphaStart
        errorLabel.isHidden = false
        errorLabel.text = message
        errorLabel.font = UIFont.systemFont(ofSize: Constants.errorLabelFontSize)
        errorLabel.textColor = errorColor
        errorLabel.pinCenterX(view)
        errorLabel.pinTop(chakchatStackView.bottomAnchor, Constants.errorLabelTop)
        errorLabel.setWidth(Constants.maxWidth)
        errorLabel.numberOfLines = Constants.numberOfLines
        errorLabel.lineBreakMode = .byWordWrapping
        errorLabel.textAlignment = .center
        
        // Slowly increase alpha to 1 for full visibility.
        UIView.animate(withDuration: Constants.errorDuration, animations: {
            self.errorLabel.alpha = Constants.alphaEnd
        })

        // Hide label with animation
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.errorMessageDuration) {
            UIView.animate(withDuration: Constants.errorDuration, animations: {
                self.errorLabel.alpha = Constants.alphaStart
            }, completion: { _ in
                self.errorLabel.isHidden = true
            })
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
        inputNumberTextField.placeholder = Constants.inputNumberTextFieldPlaceholder
        
        inputNumberTextField.pinTop(chakchatStackView.bottomAnchor, Constants.inputNumberTextFieldTopAnchor)
        inputNumberTextField.setHeight(Constants.inputNumberTextFieldHeight)
        inputNumberTextField.setWidth(Constants.inputNumberTextFieldWidth)
        inputNumberTextField.pinCenterX(view)
        
        inputNumberTextField.borderStyle = .none
        inputNumberTextField.layer.cornerRadius = Constants.inputNumberTextFieldCornerRadius
        inputNumberTextField.layer.borderWidth = Constants.inputNumberTextFieldBorderWidth
        inputNumberTextField.layer.borderColor = inputFieldColor.cgColor
        
        inputNumberTextField.keyboardType = .numberPad
        inputNumberTextField.borderStyle = .roundedRect
        let paddingView = UIView(
            frame: CGRect(
                x: Constants.inputNumberPaddingX,
                y: Constants.inputNumberPaddingY,
                width: Constants.inputNumberTextFieldPaddingWidth,
                height: inputNumberTextField.frame.height
            )
        )
        inputNumberTextField.leftView = paddingView
        inputNumberTextField.leftViewMode = .always
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
            .foregroundColor: linksColor,
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
        
        let cleanedPhone = inputNumberTextField.text!.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        if isPhoneNubmerInputValid {
            interactor.sendCodeRequest(
                SendCodeModels.SendCodeRequest(
                    phone: cleanedPhone)
            )
        } else {
//            print("Input correct phone number")
            showShortPhoneNumberError()
        }
    }
    
    // MARK: - Short Number error handling
    private func showShortPhoneNumberError() {
        view.addSubview(shortNumberLabel)
        shortNumberLabel.alpha = Constants.alphaStart
        shortNumberLabel.isHidden = false
        shortNumberLabel.text = Constants.shortNumberLabelText
        shortNumberLabel.font = UIFont.systemFont(ofSize: Constants.descriptionLabelFontSize)
        shortNumberLabel.textColor = errorColor
        shortNumberLabel.pinCenterX(view)
        shortNumberLabel.pinTop(view, Constants.shortNumberLabelTop)
        
        // Slowly increase alpha to 1 for full visibility.
        UIView.animate(withDuration: Constants.shortNumberDuration, animations: {
            self.shortNumberLabel.alpha = Constants.alphaEnd
        })

        // Hide label with animation
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.errorMessageDuration) {
            UIView.animate(withDuration: Constants.shortNumberDuration, animations: {
                self.shortNumberLabel.alpha = Constants.alphaStart
            }, completion: { _ in
                self.shortNumberLabel.isHidden = true
            })
        }
    }
}

// MARK: - UITextFieldDelegate
extension SendCodeViewController: UITextFieldDelegate {
    // hello world
}

// MARK: - PhoneNumberTextField
class PhoneNumberTextField: UITextField, UITextFieldDelegate {
    
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
        self.keyboardType = .numberPad
        self.delegate = self
        self.font = SendCodeViewController.Constants.inputPhoneFont

        let text = "+7(9"
        let attributedString = NSMutableAttributedString(string: text)
        let kerning: CGFloat = SendCodeViewController.Constants.numberKerning
        attributedString.addAttribute(.kern, value: kerning, range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedString

        self.addTarget(self, action: #selector(formatPhoneNumber), for: .editingChanged)
    }
    
    // MARK: - Phone Number Formatting
    @objc private func formatPhoneNumber() {
        guard let text = self.text else { return }
        
        // Remove all characters except numbers.
        let rawNumber = text.replacingOccurrences(of: "\\D", with: "", options: .regularExpression)
        
        // If the number does not start with "+79" we reset the field.
        guard rawNumber.hasPrefix("79") else {
            self.text = "+7(9"
            return
        }

        var formattedNumber = "+7(9"
        
        // Add grouping of numbers in the format +7(XXX)-XXX-XX-XX.
        if rawNumber.count > 2 {
            let startIndex = rawNumber.index(rawNumber.startIndex, offsetBy: 2)
            let endIndex = rawNumber.index(startIndex, offsetBy: min(2, rawNumber.count - 2))
            formattedNumber += rawNumber[startIndex..<endIndex]
        }
        if rawNumber.count > 4 {
            formattedNumber += ")"
            let startIndex = rawNumber.index(rawNumber.startIndex, offsetBy: 4)
            let endIndex = rawNumber.index(startIndex, offsetBy: min(3, rawNumber.count - 4))
            formattedNumber += rawNumber[startIndex..<endIndex]
        }
        if rawNumber.count > 7 {
            formattedNumber += "-"
            let startIndex = rawNumber.index(rawNumber.startIndex, offsetBy: 7)
            let endIndex = rawNumber.index(startIndex, offsetBy: min(2, rawNumber.count - 7))
            formattedNumber += rawNumber[startIndex..<endIndex]
        }
        if rawNumber.count > 9 {
            formattedNumber += "-"
            let startIndex = rawNumber.index(rawNumber.startIndex, offsetBy: 9)
            let endIndex = rawNumber.index(startIndex, offsetBy: min(2, rawNumber.count - 9))
            formattedNumber += rawNumber[startIndex..<endIndex]
        }
        
        self.text = formattedNumber
    }
    
    // MARK: Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Disable editing of first 4 characters.
        if range.location < 4 {
            return false
        }
        return true
    }
}

