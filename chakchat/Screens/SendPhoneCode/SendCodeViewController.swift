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
        
        static let descriptionLabelText: String = "by continuing, you agree to our"
        
        static let policyLabelFont: UIFont = UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        static let termOfServiceLabelText: String = "temp of service"
        static let privacyPolicyLabelText: String = "privacy policy"
        static let contentPoliciesLabelText: String = "content policies"
        
        static let policyStackViewSpacing: CGFloat = 5
        static let policyStackViewTopAnchor: CGFloat = 5
        
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
        chakchatStackView.pinCentreX(view)
    }
    
    // MARK: - Input Number Text Field Configuration
    private func configureInputNumberTextField() {
        view.addSubview(inputNumberTextField)
        inputNumberTextField.placeholder = Constants.inputNumberTextFieldPlaceholder
        
        inputNumberTextField.pinTop(chakchatStackView.bottomAnchor, Constants.inputNumberTextFieldTopAnchor)
        inputNumberTextField.setHeight(Constants.inputNumberTextFieldHeight)
        inputNumberTextField.setWidth(Constants.inputNumberTextFieldWidth)
        inputNumberTextField.pinCentreX(view)
        
        inputNumberTextField.borderStyle = .none
        inputNumberTextField.layer.cornerRadius = 8
        inputNumberTextField.layer.borderWidth = 1
        inputNumberTextField.layer.borderColor = inputFieldColor.cgColor
        
        inputNumberTextField.keyboardType = .numberPad
        inputNumberTextField.borderStyle = .roundedRect
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: Constants.inputNumberTextFieldPaddingWidth, height: inputNumberTextField.frame.height))
        inputNumberTextField.leftView = paddingView
        inputNumberTextField.leftViewMode = .always
        inputNumberTextField.delegate = self
    }
    
    // MARK: - Input Button Configuration
    private func configureInputButton() {
        view.addSubview(sendGradientButton)
        sendGradientButton.pinCentreX(view)
        sendGradientButton.pinTop(inputNumberTextField.bottomAnchor, UIConstants.gradientButtonTopAnchor)
        sendGradientButton.setHeight(UIConstants.gradientButtonHeight)
        sendGradientButton.setWidth(UIConstants.gradientButtonWidth)
        sendGradientButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
        
    // MARK: - Disclaimer View Configuration
    private func configureDisclaimerView() {
        view.addSubview(disclaimerView)
        disclaimerView.addSubview(descriptionLabel)
        
        descriptionLabel.text = Constants.descriptionLabelText
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 18)

        linksTextView.isEditable = false
        linksTextView.isScrollEnabled = false
        linksTextView.backgroundColor = .clear
        
        let attributedString = NSMutableAttributedString(
            string: "term of service  privacy policy  content policies",
            attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.gray,
            ]
        )
        
        // in value property we have to put link
        attributedString.addAttribute(.link, value: "terms://", range: NSRange(location: 0, length: 15))
        attributedString.addAttribute(.link, value: "privacy://", range: NSRange(location: 17, length: 14))
        attributedString.addAttribute(.link, value: "content://", range: NSRange(location: 33, length: 16))
        
        linksTextView.attributedText = attributedString
        linksTextView.linkTextAttributes = [
            .foregroundColor: linksColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        linksTextView.translatesAutoresizingMaskIntoConstraints = false
        disclaimerView.addSubview(linksTextView)
        
        disclaimerView.pinLeft(view.leadingAnchor, 20)
        disclaimerView.pinRight(view.trailingAnchor, 20)
        disclaimerView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 10)
        
        descriptionLabel.pinTop(disclaimerView.topAnchor, 0)
        descriptionLabel.pinCentreX(disclaimerView)
        
        linksTextView.pinTop(descriptionLabel.bottomAnchor, 4)
        linksTextView.pinCentreX(disclaimerView)
        linksTextView.pinBottom(disclaimerView.bottomAnchor, 0)
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

