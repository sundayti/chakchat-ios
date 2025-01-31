//
//  VerifyViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit

// MARK: - VerifyViewController
final class VerifyViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let inputPhoneFont: UIFont = UIFont.loadCustomFont(name: "RobotoMono-Regular", size: 28)
        static let inputHintLabelText: String = "Enter the code"
        static let inputHintLabelFont: UIFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        static let inputHintLabelTopAnchor: CGFloat = 10
        static let backButtonName: String = "arrow.left"
        
        static let inputDescriptionNumberOfLines: Int = 2
        static let inputDescriptionTop: CGFloat = 10
        
        static let digitsStackViewSpacing: CGFloat = 10
        static let digitsStackViewHeight: CGFloat = 50
        static let digitsStackViewTop: CGFloat = 20
        static let digitsStackViewLeading: CGFloat = 40
        static let digitsStackViewTrailing: CGFloat = 40
        
        static let textFieldBorderWidth: CGFloat = 1
        static let textFieldCornerRadius: CGFloat = 15
        static let textFieldFont: CGFloat = 24
        
        static let alphaStart: CGFloat = 0
        static let alphaEnd: CGFloat = 1
        static let errorLabelFontSize: CGFloat = 18
        static let errorLabelTop: CGFloat = 10
        static let errorDuration: TimeInterval = 0.5
        static let errorMessageDuration: TimeInterval = 2
        static let numberOfLines: Int = 2
        static let maxWidth: CGFloat = 320
        
        static let timerLabelBottom: CGFloat = 50
        static let extraKeyboardIndent: CGFloat = 40
        
        static let resendButtonHeight: CGFloat = 48
        static let resendButtonWidth: CGFloat = 230
        static let resendButtonFont: UIFont = UIFont.systemFont(ofSize: 25, weight: .bold)
    }
    
    // MARK: - Fields
    private var interactor: VerifyBusinessLogic
    private var textFields: [UITextField] = []
    private var inputDescriptionText: String = "We sent you a verification code via SMS\non number "
    private var countdownTimer: Timer?
    
    private lazy var remainingTime: TimeInterval = 0
    private lazy var rawPhone: String = ""
    private lazy var chakchatStackView: UIChakChatStackView = UIChakChatStackView()
    private lazy var inputHintLabel: UILabel = UILabel()
    private lazy var inputDescriptionLabel: UILabel = UILabel()
    private lazy var digitsStackView: UIStackView = UIStackView()
    private lazy var timerLabel: UILabel = UILabel()
    private lazy var errorLabel: UIErrorLabel = UIErrorLabel(width: Constants.maxWidth, numberOfLines: Constants.numberOfLines)
    private lazy var resendButton: UIGradientButton = UIGradientButton(title: "Resend Code")
    
    let timerDuration: TimeInterval = 90.0
    
    // MARK: - Lifecycle
    init(interactor: VerifyBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        overrideUserInterfaceStyle = .light
        let backButton = UIBarButtonItem(image: UIImage(systemName: Constants.backButtonName), style: .plain, target: self, action: #selector(backButtonPressed))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
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

    // MARK: - Show Phone
    func showPhone(_ phone: String) {
        guard let prettyPhone = formattingNumber(phone) else {
            return
        }
        inputDescriptionText += prettyPhone
        rawPhone = phone
    }
    
    // MARK: - Show Error as label
    func showError(_ message: String?) {
        if message != nil {
            errorLabel.showError(message)
            if message == "Incorrect code" {
                incorrectCode()
            }
        }
    }
    
    // MARK: - Show Timer and Hide Resend Button
    func hideResendButton() {
        resendButton.isHidden = true
        timerLabel.isHidden = false
        timerLabel.alpha = 1.0
        timerLabel.text = "Resend code in \(formatTime(Int(timerDuration)))"
        remainingTime = timerDuration
        startCountdown()
    }
    
    // MARK: - Incorrect Code Handling Method
    private func incorrectCode() {
        for i in 0..<textFields.count {
            if textFields.indices.contains(i), let thirdTextField = textFields[i] as? UIDeletableTextField {
                thirdTextField.shakeAndChangeColor()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for i in 0..<self.textFields.count {
                self.textFields[i].text = ""
            }
            if let firstTextField = self.textFields.first {
                firstTextField.becomeFirstResponder()
            }
        }
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureChakChatStackView()
        configureInputHintLabel()
        interactor.getPhone()
        configureInputDescriptionLabel()
        configureDigitsStackView()
        configureErrorLabel()
        configureTimerLabel()
        configureResendButton()
    }
    
    // MARK: - ChakChat Configuration
    private func configureChakChatStackView() {
        view.addSubview(chakchatStackView)
        chakchatStackView.pinCenterX(view)
        chakchatStackView.pinTop(view.safeAreaLayoutGuide.topAnchor, UIConstants.chakchatStackViewTopAnchor)
    }
    
    // MARK: - Input Hint Label Configuration
    private func configureInputHintLabel() {
        view.addSubview(inputHintLabel)
        inputHintLabel.text = Constants.inputHintLabelText
        inputHintLabel.font = Constants.inputHintLabelFont
        inputHintLabel.pinCenterX(view)
        inputHintLabel.pinTop(chakchatStackView.bottomAnchor, Constants.inputHintLabelTopAnchor)
    }
    
    // MARK: - Input Description Configuration
    private func configureInputDescriptionLabel() {
        view.addSubview(inputDescriptionLabel)
        inputDescriptionLabel.textAlignment = .center
        inputDescriptionLabel.numberOfLines = Constants.inputDescriptionNumberOfLines
        inputDescriptionLabel.textColor = .gray
        inputDescriptionLabel.text = inputDescriptionText
        inputDescriptionLabel.pinCenterX(view)
        inputDescriptionLabel.pinTop(inputHintLabel.bottomAnchor, Constants.inputDescriptionTop)
    }
    
    // MARK: - Digits StackView Configuration
    private func configureDigitsStackView() {
        view.addSubview(digitsStackView)
        digitsStackView.axis = .horizontal
        digitsStackView.distribution = .fillEqually
        digitsStackView.spacing = Constants.digitsStackViewSpacing
        
        for i in 0..<6 {
            let textField = UIDeletableTextField()
            textField.layer.borderWidth = Constants.textFieldBorderWidth
            textField.layer.borderColor = UIColor.gray.cgColor
            textField.layer.cornerRadius = Constants.textFieldCornerRadius
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: Constants.textFieldFont)
            textField.keyboardType = .numberPad
            textField.delegate = self
            textField.tag = i
            digitsStackView.addArrangedSubview(textField)
            textFields.append(textField)
        }
        
        digitsStackView.setHeight(Constants.digitsStackViewHeight)
        digitsStackView.pinTop(inputDescriptionLabel.bottomAnchor, Constants.digitsStackViewTop)
        digitsStackView.pinCenterX(view)
        digitsStackView.pinLeft(view.leadingAnchor, Constants.digitsStackViewLeading)
        digitsStackView.pinRight(view.trailingAnchor, Constants.digitsStackViewTrailing)
    }
    
    // MARK: - Error Label Configuration
    private func configureErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.pinCenterX(view)
        errorLabel.pinTop(digitsStackView.bottomAnchor, Constants.errorLabelTop)
    }
    
    // MARK: - Timer Label Configuration
    private func configureTimerLabel() {
        view.addSubview(timerLabel)
        timerLabel.pinCenterX(view)
        timerLabel.pinBottom(view, Constants.timerLabelBottom)
        timerLabel.textAlignment = .center
        timerLabel.textColor = .lightGray
        timerLabel.text = "Resend code in \(formatTime(Int(timerDuration)))"
        remainingTime = timerDuration
        startCountdown()
    }
    
    // MARK: - Resend Button Configuration
    private func configureResendButton() {
        view.addSubview(resendButton)
        resendButton.pinCenterX(view)
        resendButton.pinBottom(view, Constants.timerLabelBottom)
        resendButton.setHeight(Constants.resendButtonHeight)
        resendButton.setWidth(Constants.resendButtonWidth)
        resendButton.titleLabel?.font = Constants.resendButtonFont
        resendButton.addTarget(self, action: #selector(resendButtonPressed), for: .touchUpInside)
        resendButton.isHidden = true
    }
    
    // MARK: - Supporting Methods
    private func areAllTextFieldsFilled() -> Bool {
        for field in textFields {
            if field.text?.isEmpty == true {
                return false
            }
        }
        return true
    }
    
    // MARK: - Get Code From Text Fields Method
    private func getCodeFromTextFields() -> String {
        var code: String = ""
        
        for field in textFields {
            guard let text = field.text, !text.isEmpty else {
                print("Empty text field found")
                return code
            }
            code.append(text)
        }
        print(code)
        return code
    }
    
    // MARK: - Formatting Raw Number
    private func formattingNumber(_ number: String) -> String? {
        guard number.count == 11 else {
            print("Incorrect number length")
            return nil
        }
        let formattedNumber = "+7 (\(number.prefix(4).suffix(3))) \(number.prefix(7).suffix(3))-\(number.prefix(9).suffix(2))-\(number.suffix(2))"
        
        return formattedNumber
    }
    
    // MARK: - Format Time
    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: - Start Countdown
    func startCountdown() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        interactor.routeToSendCodeScreen(AppState.sendPhoneCode)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height

        // Raise view's elements if the keyboard overlaps the error label.
        // Check the overlap through digits stack view, because usually the error label is hidden.
        if let digitsFrame = digitsStackView.superview?.convert(digitsStackView.frame, to: nil) {
            let bottomY = digitsFrame.maxY
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
    
    @objc func updateLabel() {
        remainingTime -= 1
        if remainingTime > 0 {
            timerLabel.text = "Resend code in \(formatTime(Int(remainingTime)))"
        } else {
            countdownTimer?.invalidate()
            hideLabel()
        }
    }

    @objc func hideLabel() {
        UIView.animate(withDuration: 0.5, animations: {
            self.timerLabel.alpha = 0.0
        }) { _ in
            self.timerLabel.isHidden = true
        }
        resendButton.isHidden = false
    }
    
    @objc
    private func resendButtonPressed() {
        UIView.animate(withDuration: UIConstants.animationDuration, animations: {
            self.resendButton.transform = CGAffineTransform(scaleX: UIConstants.buttonScale, y: UIConstants.buttonScale)
            }, completion: { _ in
            UIView.animate(withDuration: UIConstants.animationDuration) {
                self.resendButton.transform = CGAffineTransform.identity
            }
        })
        interactor.resendCodeRequest(
            Verify.ResendCodeRequest(
                phone: rawPhone)
        )
    }
}

// MARK: - UITextFieldDelegate Extension
extension VerifyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        // If there are not only digits, don't paste it.
        if !allowedCharacters.isSuperset(of: characterSet) {
            return false
        }
        
        // If the text is entering (from clipboard for example).
        if string.count > 1 {
            // Clear all fields.
            for field in textFields {
                field.text = ""
            }
            
            // Put one character in one field.
            for (index, char) in string.enumerated() {
                if index < textFields.count {
                    textFields[index].text = String(char)
                }
            }
            
            // If all characters are set, go to last field.
            if string.count <= textFields.count {
                textFields[string.count - 1].becomeFirstResponder()
            } else {
                textFields.last?.becomeFirstResponder()
            }
            
            if areAllTextFieldsFilled() {
                let code = getCodeFromTextFields()
                interactor.sendVerificationRequest(code)
            }
            
            return false
        }
        
        // If we set a single character.
        guard let _ = textField.text, string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil || string.isEmpty else {
            return false
        }
        
        if !string.isEmpty {
            textField.text = string
        }
        
        // Go to next field if there is a character in the current.
        let nextTag = textField.tag + 1
        if !string.isEmpty, nextTag < textFields.count {
            textFields[nextTag].becomeFirstResponder()
        }
        
        // Chack if all fields are full and send request to server.
        if areAllTextFieldsFilled() {
            let code = getCodeFromTextFields()
            interactor.sendVerificationRequest(code)
        } else {
            print("Fill all fields")
        }
        
        // Deleting character.
        if string.isEmpty {
            if textField.tag > 0 { // If it isn't first cell.
                textFields[textField.tag].text = "" // Clear current cell.
                let prevTag = textField.tag - 1 // Go to previous cell.
                textFields[prevTag].becomeFirstResponder()
            } else if textField.tag == 0 { // If we are in first cell.
                textFields[textField.tag].text = "" // Clear the cell.
            }
        }
        
        return false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.endOfDocument, to: textField.endOfDocument)
    }
}

