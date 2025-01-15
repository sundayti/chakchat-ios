//
//  SignupViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
final class SignupViewController: UIViewController {
    
    enum Constants {
    
        static let inputPhoneFont: UIFont = UIFont(name: "RobotoMono-Regular", size: 28)!
        
        static let inputButtonHeight: CGFloat = 50
        static let inputButtonWidth: CGFloat = 200
        static let inputButtonFont: UIFont = UIFont.systemFont(ofSize: 26, weight: .bold)
        static let inputButtonTopAnchor: CGFloat = 40
        static let inputButtonGradientColor: [CGColor] = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        
        static let inputButtonGradientStartPoint: CGPoint = CGPoint(x: 0.0, y: 0.5)
        static let inputButtonGradientEndPoint: CGPoint = CGPoint(x: 1, y: 0.5)
        static let inputButtonGradientCornerRadius: CGFloat = 25
        
    }
    
    private let interactor: SignupBusinessLogic
    
    private lazy var chakchatStackView: UIChakChatStackView = UIChakChatStackView()
    private lazy var nameTextField: UITextField = UITextField()
    private lazy var usernameTextField: UITextField = UITextField()
    private lazy var sendGradientButton: UIGradientButton = UIGradientButton(title: "Enter")
    
    private var isNameInputValid: Bool = false
    private var isUsernameInputValid: Bool = false
    
    init(interactor: SignupBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
        navigationItem.leftBarButtonItem = backButton
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureChakChatStackView()
        configureNameTextField()
        configureUsernameTextField()
        configureInputButton()
    }
    
    private func configureChakChatStackView() {
        view.addSubview(chakchatStackView)
        chakchatStackView.pinTop(view.safeAreaLayoutGuide.topAnchor, UIConstants.chakchatStackViewTopAnchor)
        chakchatStackView.pinCentreX(view)
    }
    
    private func configureNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        nameTextField.placeholder = "Name"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTextField.frame.height))
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
        nameTextField.delegate = self
        nameTextField.pinTop(chakchatStackView.bottomAnchor, 40)
        nameTextField.pinCentreX(view)
        nameTextField.setHeight(50)
        nameTextField.setWidth(300)
    }
    
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect
        usernameTextField.placeholder = "Username"
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: usernameTextField.frame.height))
        usernameTextField.leftView = paddingView
        usernameTextField.leftViewMode = .always
        usernameTextField.delegate = self
        usernameTextField.pinTop(nameTextField.bottomAnchor, 20)
        usernameTextField.pinCentreX(view)
        usernameTextField.setHeight(50)
        usernameTextField.setWidth(300)
    }
    
    private func configureInputButton() {
        view.addSubview(sendGradientButton)
        sendGradientButton.pinCentreX(view)
        sendGradientButton.pinTop(usernameTextField.bottomAnchor, UIConstants.gradientButtonTopAnchor)
        sendGradientButton.setHeight(UIConstants.gradientButtonHeight)
        sendGradientButton.setWidth(UIConstants.gradientButtonWidth)
        sendGradientButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
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
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    private func sendButtonPressed() {
        interactor.sendSignupRequest(nameTextField.text!, usernameTextField.text!)
    }
}

extension SignupViewController: UITextFieldDelegate {
    
}
