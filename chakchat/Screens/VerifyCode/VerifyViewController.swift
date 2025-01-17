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
        static let inputPhoneFont: UIFont = UIFont(name: "RobotoMono-Regular", size: 28)!
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
    private lazy var digitsBorderColor: UIColor = UIColor(hex: "#FF6200") ?? UIColor.orange
    private lazy var errorColor: UIColor = UIColor(hex: "FF6200") ?? UIColor.orange
    private lazy var digitsStackView: UIStackView = UIStackView()
    private lazy var errorLabel: UILabel = UILabel()
    
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
        view.addSubview(errorLabel)
        errorLabel.alpha = Constants.alphaStart
        errorLabel.isHidden = false
        errorLabel.text = message
        errorLabel.font = UIFont.systemFont(ofSize: Constants.errorLabelFontSize)
        errorLabel.textColor = errorColor
        errorLabel.pinCenterX(view)
        errorLabel.pinTop(digitsStackView.bottomAnchor, Constants.errorLabelTop)
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
        configureChakChatStackView()
        configureInputHintLabel()
        configureInputDescriptionLabel()
        configureDigitsStackView()
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
            let textField = MyTextField()
            textField.layer.borderWidth = Constants.textFieldBorderWidth
            textField.layer.borderColor = digitsBorderColor.cgColor
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

    // MARK: - TextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Если в поле уже есть текст, выделяем его весь
        if let text = textField.text, !text.isEmpty {
            textField.selectAll(nil)
        }
    }
    // Буду писать на русском, чтобы ты точно поняла, для чего это надо
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Проверяем, что введенные данные являются цифрой + только один символ
        guard let _ = textField.text, string.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil || string.isEmpty else {
            return false // В противном случае не дает вводить
        }
        
        if !string.isEmpty {
            textField.text = string // Если введенное значение не nil, то записываем в ячейку
        }
        
        // Если текущее значение в ячейке не nil и следующий индекс не больше количества ячеек массиве
        // то переходим в следующее поле
        let nextTag = textField.tag + 1
        if !string.isEmpty, nextTag < textFields.count {
            textFields[nextTag].becomeFirstResponder()
        }
        
        // Делаем расфокус + запрос на сервер, когда все поля заполнены
        if areAllTextFieldsFilled() {
            let code = getCodeFromTextFields()
            interactor.sendVerificationRequest(code)
        } else {
            print("Fill all fields")
        }
        
        // Удаление символов
        if string.isEmpty {
            if textField.tag > 0 { // Если мы не в последней ячейке
                textFields[textField.tag].text = "" // Меняем содержимое ячейки на ""
                let prevTag = textField.tag - 1 // Находим индекс предыдущей ячейки
                textFields[prevTag].becomeFirstResponder() // Переходим на нее
            } else if textField.tag == 0 { // Если мы в последней ячейке
                textFields[textField.tag].text = "" // Меняем содержимое ячейки на "", но никуда не переходим
            }
        }
        
        return false // По дефолту, не заходя ни в какие if, не даем никак редактировать ячейки
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
            code.append(field.text!)
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
// Специальный класс, чтобы при нажатии на backspace курсор переносился на ячейку влево(если ячейка пустая)
class MyTextField: UITextField {
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

