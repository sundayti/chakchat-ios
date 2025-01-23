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
        static let inputDescriptionText: String = "We sent you a verification code via SMS\non number +7(9**)***-**-**."
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
    }
    
    // MARK: - Fields
    private var interactor: VerifyBusinessLogic
    private var textFields: [UITextField] = []
    
    private lazy var chakchatStackView: UIChakChatStackView = UIChakChatStackView()
    private lazy var inputHintLabel: UILabel = UILabel()
    private lazy var inputDescriptionLabel: UILabel = UILabel()
    private lazy var digitsStackView: UIStackView = UIStackView()
    private lazy var errorLabel: UIErrorLabel = UIErrorLabel(width: Constants.maxWidth, numberOfLines: Constants.numberOfLines)
    
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
    
    // MARK: - Show Error as label
    func showError(_ message: String?) {
        if message != nil {
            errorLabel.showError(message)
        }
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureChakChatStackView()
        configureInputHintLabel()
        configureInputDescriptionLabel()
        configureDigitsStackView()
        configurateErrorLabel()
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
        inputDescriptionLabel.text = Constants.inputDescriptionText
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
            let textField = DeletableTextField()
            textField.layer.borderWidth = Constants.textFieldBorderWidth
            textField.layer.borderColor = Colors.orange.cgColor
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
    private func configurateErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.pinCenterX(view)
        errorLabel.pinTop(digitsStackView.bottomAnchor, Constants.errorLabelTop)
    }


    // MARK: - TextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // If there is already text in field, select it.
        if let text = textField.text, !text.isEmpty {
            textField.selectAll(nil)
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if entered data is number and it is a one character.
        guard let _ = textField.text, string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil || string.isEmpty else {
            return false
        }
        
        if !string.isEmpty {
            textField.text = string  // If the entered text is not nil, write it.
        }
        
        // If current value in the cell is not nil and next index not greater that amount of cells in array,
        // go to next field.
        let nextTag = textField.tag + 1
        if !string.isEmpty, nextTag < textFields.count {
            textFields[nextTag].becomeFirstResponder()
        }
        
        // We make a defocus + request to the server when all fields are filled.
        if areAllTextFieldsFilled() {
            let code = getCodeFromTextFields()
            interactor.sendVerificationRequest(code)
        } else {
            print("Fill all fields")
        }
        
        // Deleting character.
        if string.isEmpty {
            if textField.tag > 0 { // If we not in last cell.
                textFields[textField.tag].text = "" // Change the value in cell to "".
                let prevTag = textField.tag - 1 // Find previous index.
                textFields[prevTag].becomeFirstResponder() // Go to previous cell.
            } else if textField.tag == 0 { // If we in last cell
                textFields[textField.tag].text = "" // Change the value but don't go anywhere.
            }
        }
        
        return false
    }
    
    // MARK: - Supporting Methods
    func areAllTextFieldsFilled() -> Bool {
        for field in textFields {
            if field.text?.isEmpty == true {
                return false
            }
        }
        return true
    }
    
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
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        interactor.routeToSendCodeScreen(AppState.sendPhoneCode)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate Extension
extension VerifyViewController: UITextFieldDelegate {}


// MARK: - Custom UITextField
// Special class so that when you press backspace the cursor moves to the cell to the left (if the cell is empty).
class DeletableTextField: UITextField {
    override public func deleteBackward() {
        super.deleteBackward()
        if let previousTextField = getPreviousTextField() {
            previousTextField.becomeFirstResponder()
        }
    }
    
    private func getPreviousTextField() -> UITextField? {
        let currentTag = self.tag
        let previousTag = currentTag - 1
        return self.superview?.viewWithTag(previousTag) as? UITextField
    }
}

