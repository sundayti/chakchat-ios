//
//  SignupViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit

// MARK: - SignupViewController
final class SignupViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let nameFont: UIFont = UIFont.loadCustomFont(name: "Inter-Regular", size: 20)
        
        static let inputButtonHeight: CGFloat = 50
        static let inputButtonWidth: CGFloat = 200
        static let inputButtonFont: UIFont = UIFont.systemFont(ofSize: 26, weight: .bold)
        static let inputButtonTopAnchor: CGFloat = 40
        static let inputButtonGradientColor: [CGColor] = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        
        static let inputButtonGradientStartPoint: CGPoint = CGPoint(x: 0.0, y: 0.5)
        static let inputButtonGradientEndPoint: CGPoint = CGPoint(x: 1, y: 0.5)
        static let inputButtonGradientCornerRadius: CGFloat = 25
        
        static let nameTextFieldPlaceholder: String = "Name"
        static let namePaddingX: CGFloat = 0
        static let namePaddingY: CGFloat = 0
        static let namePaddingWidth: CGFloat = 10
        static let nameTextFieldTop: CGFloat = 40
        static let nameTextFieldHeight: CGFloat = 50
        static let nameTextFieldWidth: CGFloat = 300
        
        static let borderCornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
        
        static let usernameTextFieldPlaceholder: String = "Username"
        static let usernamePaddingX: CGFloat = 0
        static let usernamePaddingY: CGFloat = 0
        static let usernamePaddingWidth: CGFloat = 10
        static let usernameTextFieldTop: CGFloat = 20
        static let usernameTextFieldHeight: CGFloat = 50
        static let usernameTextFieldWidth: CGFloat = 300
        
        static let createButtonHeight: CGFloat = 38
        static let createButtonWidth: CGFloat = 228
        static let createButtonFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        static let alphaStart: CGFloat = 0
        static let alphaEnd: CGFloat = 1
        static let errorLabelFontSize: CGFloat = 18
        static let errorLabelTop: CGFloat = -8
        static let errorDuration: TimeInterval = 0.5
        static let errorMessageDuration: TimeInterval = 2
        static let maxWidth: CGFloat = 310
        static let numberOfLines: Int = 2
    }
    
    // MARK: - Properties
    private let interactor: SignupBusinessLogic

    private lazy var chakchatStackView: UIChakChatStackView = UIChakChatStackView()
    private lazy var nameTextField: UITextField = UITextField()
    private lazy var usernameTextField: UITextField = UITextField()
    private lazy var sendGradientButton: UIGradientButton = UIGradientButton(title: "Create account")
    private lazy var errorLabel: UIErrorLabel = UIErrorLabel(width: Constants.maxWidth, numberOfLines: Constants.numberOfLines)
    
    private var isNameInputValid: Bool = false
    private var isUsernameInputValid: Bool = false
    
    // MARK: - Lifecycle
    init(interactor: SignupBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        overrideUserInterfaceStyle = .light
        view.addGestureRecognizer(tapGesture)
        
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
        configureChakChatStackView()
        configureNameTextField()
        configureUsernameTextField()
        configureInputButton()
        configurateErrorLabel()
    }
    
    // MARK: - ChakChat Configuration
    private func configureChakChatStackView() {
        view.addSubview(chakchatStackView)
        chakchatStackView.pinTop(view.safeAreaLayoutGuide.topAnchor, UIConstants.chakchatStackViewTopAnchor)
        chakchatStackView.pinCenterX(view)
    }
    
    // MARK: - Name Text Field Configuration
    private func configureNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.placeholder = Constants.nameTextFieldPlaceholder
        let paddingView = UIView(
            frame: CGRect(
                x: Constants.namePaddingX,
                y: Constants.namePaddingY,
                width: Constants.namePaddingWidth,
                height: nameTextField.frame.height
            )
        )
        nameTextField.font = Constants.nameFont
        nameTextField.borderStyle = .none
        nameTextField.layer.cornerRadius = Constants.borderCornerRadius
        nameTextField.layer.borderWidth = Constants.borderWidth
        nameTextField.layer.borderColor = Colors.gray.cgColor
        
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
        nameTextField.delegate = self
        nameTextField.pinTop(chakchatStackView.bottomAnchor, Constants.nameTextFieldTop)
        nameTextField.pinCenterX(view)
        nameTextField.setHeight(Constants.nameTextFieldHeight)
        nameTextField.setWidth(Constants.nameTextFieldWidth)
        
        nameTextField.autocorrectionType = .no
        nameTextField.spellCheckingType = .no
    }
    
    // MARK: - Username Text Field Configuration
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        usernameTextField.placeholder = Constants.usernameTextFieldPlaceholder
        let paddingView = UIView(
            frame: CGRect(
                x: Constants.usernamePaddingX,
                y: Constants.usernamePaddingY,
                width: Constants.usernamePaddingWidth,
                height: usernameTextField.frame.height
            )
        )
        usernameTextField.font = Constants.nameFont
        usernameTextField.borderStyle = .none
        usernameTextField.layer.cornerRadius = Constants.borderCornerRadius
        usernameTextField.layer.borderWidth = Constants.borderWidth
        usernameTextField.layer.borderColor = Colors.gray.cgColor
        
        usernameTextField.leftView = paddingView
        usernameTextField.leftViewMode = .always
        usernameTextField.delegate = self
        usernameTextField.pinTop(nameTextField.bottomAnchor, Constants.usernameTextFieldTop)
        usernameTextField.pinCenterX(view)
        usernameTextField.setHeight(Constants.usernameTextFieldHeight)
        usernameTextField.setWidth(Constants.usernameTextFieldWidth)
        
        usernameTextField.autocorrectionType = .no
        usernameTextField.spellCheckingType = .no
        usernameTextField.autocapitalizationType = .none
    }
    
    // MARK: - Input Button Configuration
    private func configureInputButton() {
        view.addSubview(sendGradientButton)
        sendGradientButton.pinCenterX(view)
        sendGradientButton.pinTop(usernameTextField.bottomAnchor, UIConstants.gradientButtonTopAnchor)
        sendGradientButton.setHeight(Constants.createButtonHeight)
        sendGradientButton.setWidth(Constants.createButtonWidth)
        sendGradientButton.titleLabel?.font = Constants.createButtonFont
        sendGradientButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Error Label Configuration
    private func configurateErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.pinCenterX(view)
        errorLabel.pinTop(chakchatStackView.bottomAnchor, Constants.errorLabelTop)
    }
    
    // MARK: - TextField Delegate Methods
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        switch(textField) {
        case nameTextField:
            let validator = SignupDataValidator()
            isNameInputValid = validator.validateName(text)
        case usernameTextField:
            let validator = SignupDataValidator()
            isUsernameInputValid = validator.validateUsername(text)
        default:
            break
        }
        updateAuthorizationButtonState()
    }
    
    private func updateAuthorizationButtonState() {
        sendGradientButton.isEnabled = isNameInputValid && isUsernameInputValid
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
        
        guard let name = nameTextField.text, !name.isEmpty,
              let username = usernameTextField.text, !username.isEmpty else {
            showError("You need to enter name and username")
            return
        }

        interactor.sendSignupRequest(name, username)
    }
}

// MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {}
