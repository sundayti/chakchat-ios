//
//  VerifyViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit
final class VerifyViewController: UIViewController {
    
    enum Constants {
        static let chakchatStackViewTopAnchor: CGFloat = 20
        
        static let chakLabelText: String = "Chak"
        static let chatLabelText: String = "Chat"
        
        static let chakchatFont: UIFont = UIFont(name: "RammettoOne-Regular", size: 80)!
        static let inputPhoneFont: UIFont = UIFont(name: "RobotoMono-Regular", size: 28)!
        
        static let chakchatStackViewSpacing: CGFloat = -50
        
        static let inputHintLabelText: String = "Enter the code"
        static let inputHintLabelFont: UIFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        static let inputHintLabelTopAnchor: CGFloat = 10
    }
    
    private var interactor: VerifyBusinessLogic
    
    
    private lazy var chakLabel: UILabel = UILabel()
    private lazy var chatLabel: UILabel = UILabel()
    private lazy var chakchatStackView = UIStackView(arrangedSubviews: [chakLabel, chatLabel])
    
    private lazy var inputHintLabel: UILabel = UILabel()
    private lazy var inputDescriptionLabel: UILabel = UILabel()
    
    private lazy var digitsStackView: UIStackView = UIStackView()
    
    
    init(interactor: VerifyBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var textFields: [UITextField] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        configureUI()
    }
    
    private func configureUI() {
        configureChakChatStackView()
        configureInputHintLabel()
        configureInputDescriptionLabel()
        configureDigitsStackView()
    }
    
    private func configureChakChatStackView() {
        view.addSubview(chakLabel)
        view.addSubview(chatLabel)
        chakLabel.text = Constants.chakLabelText
        chakLabel.textAlignment = .center
        chakLabel.font = Constants.chakchatFont
        chakLabel.textColor = .black
        
        chatLabel.text = Constants.chatLabelText
        chatLabel.textAlignment = .center
        chatLabel.font = Constants.chakchatFont
        chatLabel.textColor = .black
        
        view.addSubview(chakchatStackView)
        chakchatStackView.axis = .vertical
        chakchatStackView.alignment = .center
        chakchatStackView.spacing = Constants.chakchatStackViewSpacing
        chakchatStackView.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.chakchatStackViewTopAnchor)
        chakchatStackView.pinCentreX(view)
    }
    
    private func configureInputHintLabel() {
        view.addSubview(inputHintLabel)
        inputHintLabel.text = Constants.inputHintLabelText
        inputHintLabel.font = Constants.inputHintLabelFont
        inputHintLabel.pinCentreX(view)
        inputHintLabel.pinTop(chakchatStackView.bottomAnchor, Constants.inputHintLabelTopAnchor)
    }
    
    private func configureInputDescriptionLabel() {
        view.addSubview(inputDescriptionLabel)
        inputDescriptionLabel.textAlignment = .center
        inputDescriptionLabel.numberOfLines = 2
        inputDescriptionLabel.textColor = .gray
        inputDescriptionLabel.text = "We sent you a verification code via SMS\non number +7(9**)***-**-**."
        inputDescriptionLabel.pinCentreX(view)
        inputDescriptionLabel.pinTop(inputHintLabel.bottomAnchor, 10)
    }
    
    private func configureDigitsStackView() {
        view.addSubview(digitsStackView)
        digitsStackView.axis = .horizontal
        digitsStackView.distribution = .fillEqually
        digitsStackView.spacing = 10
        
        for i in 0..<6 {
            let textField = MyTextField()
            
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.orange.cgColor
            textField.layer.cornerRadius = 15
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 24)
            textField.keyboardType = .numberPad
            textField.delegate = self
            textField.tag = i
            digitsStackView.addArrangedSubview(textField)
            textFields.append(textField)
        }
        
        digitsStackView.setHeight(50)
        digitsStackView.pinTop(inputDescriptionLabel.bottomAnchor, 20)
        digitsStackView.pinCentreX(view)
        digitsStackView.pinLeft(view.leadingAnchor, 40)
        digitsStackView.pinRight(view.trailingAnchor, 40)
    }

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
    
    // Метод который проверяет что все элементы textFields не пустые
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
    
    @objc
    private func backButtonPressed() {
        interactor.routeToSendCodeScreen(AppState.sendPhoneCode)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension VerifyViewController: UITextFieldDelegate {

}
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

