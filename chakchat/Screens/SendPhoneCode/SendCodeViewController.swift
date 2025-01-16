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
        static let inputPhoneFont: UIFont = UIFont(name: "RobotoMono-Regular", size: 28)!
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
    }
    
    // MARK: - Fields
    private var interactor: SendCodeBusinessLogic
    private lazy var chakchatStackView: UIChakChatStackView = UIChakChatStackView()
    private lazy var inputNumberTextField: PhoneNumberTextField = PhoneNumberTextField()
    private lazy var sendGradientButton: UIGradientButton = UIGradientButton(title: "Enter")
    private lazy var inputFieldColor: UIColor = UIColor(hex: "#383838") ?? UIColor.gray
    private lazy var linksColor: UIColor = UIColor(hex: "#FFAE00") ?? UIColor.systemYellow
    private lazy var disclaimerView: UIView = UIView()
    private lazy var descriptionLabel: UILabel = UILabel()
    private lazy var linksTextView: UITextView = UITextView()
    
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
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .white
        
        // I can tap everywhere for didEndEditing
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
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
        let cleanedPhone = inputNumberTextField.text!.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)

        if isPhoneNubmerInputValid {
            interactor.sendCodeRequest(
                SendCodeModels.SendCodeRequest(
                    phone: cleanedPhone)
            )
        } else {
            print("Input correct phone number")
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
        self.text = "+7(9"
        self.delegate = self
        self.font = SendCodeViewController.Constants.inputPhoneFont
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

