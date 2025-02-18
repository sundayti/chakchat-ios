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
        static let inputButtonHeight: CGFloat = 50
        static let inputButtonWidth: CGFloat = 200
        static let inputButtonTopAnchor: CGFloat = 40
        static let inputButtonGradientColor: [CGColor] = [UIColor.yellow.cgColor, UIColor.orange.cgColor]
        
        static let inputButtonGradientStartPoint: CGPoint = CGPoint(x: 0.0, y: 0.5)
        static let inputButtonGradientEndPoint: CGPoint = CGPoint(x: 1, y: 0.5)
        static let inputButtonGradientCornerRadius: CGFloat = 25
        
        static let nameTextFieldPlaceholder: String = LocalizationManager.shared.localizedString(for: "name")
        static let namePaddingX: CGFloat = 0
        static let namePaddingY: CGFloat = 0
        static let namePaddingWidth: CGFloat = 10
        static let nameTextFieldTop: CGFloat = 40
        static let nameTextFieldHeight: CGFloat = 50
        static let nameTextFieldWidth: CGFloat = 300
        
        static let borderCornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
        
        static let usernameTextFieldPlaceholder: String = LocalizationManager.shared.localizedString(for: "username")
        static let usernamePaddingX: CGFloat = 0
        static let usernamePaddingY: CGFloat = 0
        static let usernamePaddingWidth: CGFloat = 10
        static let usernameTextFieldTop: CGFloat = 20
        static let usernameTextFieldHeight: CGFloat = 50
        static let usernameTextFieldWidth: CGFloat = 300
        
        static let createButtonHeight: CGFloat = 38
        static let createButtonWidth: CGFloat = 228
        
        static let alphaStart: CGFloat = 0
        static let alphaEnd: CGFloat = 1
        static let errorLabelFontSize: CGFloat = 18
        static let errorLabelTop: CGFloat = -8
        static let errorDuration: TimeInterval = 0.5
        static let errorMessageDuration: TimeInterval = 2
        static let maxWidth: CGFloat = 310
        static let numberOfLines: Int = 2
        
        static let colorDuration: CFTimeInterval = 1.5
        static let extraKeyboardIndent: CGFloat = 16
    }
    
    // MARK: - Properties
    private let interactor: SignupBusinessLogic

    private lazy var chakchatStackView: UIChakChatStackView = UIChakChatStackView()
    private lazy var nameTextField: UITextField = UITextField()
    private lazy var usernameTextField: UITextField = UITextField()
    private lazy var sendGradientButton: UIGradientButton = UIGradientButton(title: LocalizationManager.shared.localizedString(for: "create_account"))
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: .languageDidChange, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        configureUI()
    }
    
    // MARK: - ViewWillAppear Overriding
    // Subscribing to Keyboard Notifications
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: - ViewWillDisappear Overriding
    // Unubscribing to Keyboard Notifications
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    
    // MARK: - Show Error as label
    func showError(_ message: String?) {
        if message != nil {
            errorLabel.showError(message)
        }
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Colors.background
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
        nameTextField.font = Fonts.interR20
        nameTextField.borderStyle = .none
        nameTextField.layer.cornerRadius = Constants.borderCornerRadius
        nameTextField.layer.borderWidth = Constants.borderWidth
        nameTextField.layer.borderColor = UIColor.gray.cgColor
        nameTextField.leftView = paddingView
        nameTextField.leftViewMode = .always
        nameTextField.delegate = self
        nameTextField.pinTop(chakchatStackView.bottomAnchor, Constants.nameTextFieldTop)
        nameTextField.pinCenterX(view)
        nameTextField.setHeight(Constants.nameTextFieldHeight)
        nameTextField.setWidth(Constants.nameTextFieldWidth)
        
        nameTextField.autocorrectionType = .no
        nameTextField.spellCheckingType = .no
        nameTextField.autocapitalizationType = .none
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
        usernameTextField.font = Fonts.interR20
        usernameTextField.borderStyle = .none
        usernameTextField.layer.cornerRadius = Constants.borderCornerRadius
        usernameTextField.layer.borderWidth = Constants.borderWidth
        usernameTextField.layer.borderColor = UIColor.gray.cgColor
        
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
        sendGradientButton.titleLabel?.font = Fonts.systemB20
        sendGradientButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Error Label Configuration
    private func configurateErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.pinCenterX(view)
        errorLabel.pinTop(chakchatStackView.bottomAnchor, Constants.errorLabelTop)
    }
    
    // MARK: - Check Name and Username Fields and Show Errors
    private func checkFields() -> Bool {
        guard let name = nameTextField.text, !name.isEmpty else {
            changeColor(nameTextField)
            showError(LocalizationManager.shared.localizedString(for: "enter_your_name"))
            return false
        }
        
        let validator = SignupDataValidator()
        isNameInputValid = validator.validateName(name)
        if (!isNameInputValid) {
            changeColor(nameTextField)
            showError(LocalizationManager.shared.localizedString(for: "name_too_long"))
            return false
        }
        
        guard let username = usernameTextField.text, !username.isEmpty else {
            changeColor(usernameTextField)
            showError(LocalizationManager.shared.localizedString(for: "enter_username"))
            return false
        }
        
        isUsernameInputValid = validator.validateUsername(username)
        if (!isUsernameInputValid) {
            changeColor(usernameTextField)
            if username.count < 2 {
                showError(LocalizationManager.shared.localizedString(for: "username_short"))
            } else if username.count > 19 {
                showError(LocalizationManager.shared.localizedString(for: "username_long"))
            } else {
                showError(LocalizationManager.shared.localizedString(for: "use_only_characters"))
            }
            return false
        }
        return true
    }
    
    // MARK: - Text Field Changing color
    func changeColor(_ field: UITextField) {
        let originalColor = field.layer.borderColor
        UIView.animate(withDuration: Constants.colorDuration, animations: {
            field.layer.borderColor = Colors.orange.cgColor
        }) { _ in
            UIView.animate(withDuration: Constants.colorDuration) {
                field.layer.borderColor = originalColor
            }
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
        
        if checkFields() {
            guard let name = nameTextField.text, !name.isEmpty,
                  let username = usernameTextField.text, !username.isEmpty else {
                return
            }
            interactor.sendSignupRequest(name, username)
        }
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height

        // Raise view's elements if the keyboard overlaps the create account button.
        if let buttonFrame = sendGradientButton.superview?.convert(sendGradientButton.frame, to: nil) {
            let bottomY = buttonFrame.maxY
            let screenHeight = UIScreen.main.bounds.height
    
            if bottomY > screenHeight - keyboardHeight {
                let overlap = bottomY - (screenHeight - keyboardHeight)
                self.view.frame.origin.y -= overlap + Constants.extraKeyboardIndent
            }
        }
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc
    private func languageDidChange() {
        nameTextField.placeholder = LocalizationManager.shared.localizedString(for: "name")
        usernameTextField.placeholder = LocalizationManager.shared.localizedString(for: "username")
        sendGradientButton.setTitle(LocalizationManager.shared.localizedString(for: "create_account"))
    }
}

// MARK: - UITextFieldDelegate
extension SignupViewController: UITextFieldDelegate {}
