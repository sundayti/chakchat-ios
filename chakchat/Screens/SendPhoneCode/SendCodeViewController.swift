//
//  RegistrationViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import UIKit
import SafariServices
import PDFKit

// MARK: - SendCodeViewController
final class SendCodeViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let inputNumberLabelFontSize: CGFloat = 16
        static let inputNumberLabelTopAnchor: CGFloat = 100
        
        static let inputNumberTextFieldTopAnchor: CGFloat = 50
        
        static let descriptionLabelText: String = NSLocalizedString("agreement_with_prompt", comment: "")
        static let descriptionLabelBottom: CGFloat = 4
        
        static let termsText: String = NSLocalizedString("terms_of_service_label", comment: "")
        static let privacyText: String = NSLocalizedString("privacy_policy_label", comment: "")
        static let contentsText: String = NSLocalizedString("content_policies_label", comment: "")
        static let linksTop: CGFloat = 4
        static let linksHorizontal: CGFloat = 20
        static let linksBottom: CGFloat = 40
        
        static let linkTermAddress: String = "https://cdnn21.img.ria.ru/images/07e7/06/0d/1877834821_25:0:3666:2048_1920x1080_80_0_0_23f7d8b4f8862f094a620c91db2e4519.jpg"
        static let linkTermLocation: Int = 0
        static let linkPrivacyAddress: String = "https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-2197299756.jpg?c=16x9&q=h_833,w_1480,c_fill"
        static let linkPrivacyLocation: Int = 17
        static let linkPrivacyLenght: Int = 14
        static let linkContentAddress: String = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/%D0%92%D0%BB%D0%B0%D0%B4%D0%B8%D0%BC%D0%B8%D1%80_%D0%9F%D1%83%D1%82%D0%B8%D0%BD_%2818-06-2023%29_%28cropped%29.jpg/640px-%D0%92%D0%BB%D0%B0%D0%B4%D0%B8%D0%BC%D0%B8%D1%80_%D0%9F%D1%83%D1%82%D0%B8%D0%BD_%2818-06-2023%29_%28cropped%29.jpg"
        static let linkContentLocation: Int = 33
        static let linkContentLenght: Int = 16
        
        static let policyStackViewSpacing: CGFloat = 5
        static let policyStackViewTopAnchor: CGFloat = 5
        
        static let inputButtonHeight: CGFloat = 48
        static let inputButtonWidth: CGFloat = 205
        static let inputButtonBigWidth: CGFloat = 235
        static let inputButtonShortCount: Int = 9
        
        static let disclaimerLeading: CGFloat = 20
        static let disclaimerTrailing: CGFloat = 20
        static let disclaimerBottom: CGFloat = 10
        
        static let disablingCharactersAmount: Int = 4
        static let numberKerning: CGFloat = 2
        
        static let shortNumberLabelText: String = NSLocalizedString("enter_valid_number", comment: "")
        static let shortNumberLabelTop: CGFloat = 360
        static let shortNumberDuration: TimeInterval = 0.5
        
        static let numberOfLines: Int = 2
        static let maxWidth: CGFloat = 330
        static let errorLabelTop: CGFloat = 0
        
        static let extraKeyboardIndent: CGFloat = 20
    }
    
    // MARK: - Properties
    private var interactor: SendCodeBusinessLogic
    private lazy var chakchatStackView: UIChakChatStackView = UIChakChatStackView()
    private lazy var inputNumberTextField: UIPhoneNumberTextField = UIPhoneNumberTextField()
    private lazy var sendGradientButton: UIGradientButton = UIGradientButton(title: NSLocalizedString("send_code", comment: ""))
    private lazy var shortNumberLabel: UILabel = UILabel()
    private lazy var descriptionLabel: UILabel = UILabel()
    private lazy var termsLabel: UILabel = UILabel()
    private lazy var privacyLabel: UILabel = UILabel()
    private lazy var contentsLabel: UILabel = UILabel()
    private lazy var errorLabel: UIErrorLabel = UIErrorLabel(width: Constants.maxWidth, numberOfLines: Constants.numberOfLines)
    private let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        self.navigationItem.hidesBackButton = true
        
        configureChakChatStackView()
        configureInputNumberTextField()
        configureInputButton()
        configureTermsView()
        configurePrivacyView()
        configureContentsView()
        configureCountinuingLabel()
        configurateErrorLabel()
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
        inputNumberTextField.pinTop(chakchatStackView.bottomAnchor, Constants.inputNumberTextFieldTopAnchor)
        inputNumberTextField.pinCenterX(view)
        inputNumberTextField.delegate = self
    }
    
    // MARK: - Input Button Configuration
    private func configureInputButton() {
        view.addSubview(sendGradientButton)
        sendGradientButton.pinCenterX(view)
        sendGradientButton.pinTop(inputNumberTextField.bottomAnchor, UIConstants.gradientButtonTopAnchor)
        sendGradientButton.setHeight(Constants.inputButtonHeight)
        guard let label = sendGradientButton.titleLabel,
              let text = label.text else {
            return
        }
        // If in title more than 9 chars, make button bigger.
        sendGradientButton.setWidth(text.count > Constants.inputButtonShortCount
                                    ? Constants.inputButtonBigWidth
                                    : Constants.inputButtonWidth)
        sendGradientButton.titleLabel?.font = Fonts.systemB25
        sendGradientButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Countinuing Label Configuration
    private func configureCountinuingLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.text = Constants.descriptionLabelText
        descriptionLabel.textColor = Colors.text
        descriptionLabel.font = Fonts.systemR15
        descriptionLabel.pinBottom(contentsLabel.topAnchor, Constants.descriptionLabelBottom)
        descriptionLabel.pinCenterX(view)
    }
    
    // MARK: - Terms View Configuration
    private func configureTermsView() {
        view.addSubview(termsLabel)
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        termsLabel.attributedText = underlineAttributedString
        termsLabel.text = Constants.termsText
        termsLabel.font = Fonts.systemR12
        termsLabel.textColor = Colors.darkYellow
        termsLabel.isUserInteractionEnabled = true
        termsLabel.lineBreakMode = .byWordWrapping
        termsLabel.numberOfLines = 1
        termsLabel.pinCenterX(view)
        termsLabel.pinBottom(view, Constants.linksBottom)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openTerms))
        termsLabel.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Privacy View Configuration
    private func configurePrivacyView() {
        view.addSubview(privacyLabel)
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        privacyLabel.attributedText = underlineAttributedString
        privacyLabel.text = Constants.privacyText
        privacyLabel.font = Fonts.systemR12
        privacyLabel.textColor = Colors.darkYellow
        privacyLabel.lineBreakMode = .byWordWrapping
        privacyLabel.isUserInteractionEnabled = true
        privacyLabel.numberOfLines = 1
        privacyLabel.pinCenterX(view)
        privacyLabel.pinBottom(termsLabel.topAnchor, Constants.descriptionLabelBottom)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openPrivacy))
        privacyLabel.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Contents View Configuration
    private func configureContentsView() {
        view.addSubview(contentsLabel)
        let underlineAttributedString = NSAttributedString(string: "StringWithUnderLine", attributes: underlineAttribute)
        contentsLabel.attributedText = underlineAttributedString
        contentsLabel.text = Constants.contentsText
        contentsLabel.font = Fonts.systemR12
        contentsLabel.textColor = Colors.darkYellow
        contentsLabel.lineBreakMode = .byWordWrapping
        contentsLabel.isUserInteractionEnabled = true
        contentsLabel.numberOfLines = 1
        contentsLabel.pinCenterX(view)
        contentsLabel.pinBottom(privacyLabel.topAnchor, Constants.descriptionLabelBottom)

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openContents))
        contentsLabel.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Error Label Configuration
    private func configurateErrorLabel() {
        view.addSubview(errorLabel)
        errorLabel.pinCenterX(view)
        errorLabel.pinTop(chakchatStackView.bottomAnchor, Constants.errorLabelTop)
    }

    // MARK: - TextField Handling
    func textFieldDidEndEditing(_ textField: UITextField) {
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
        
        guard let phoneText = inputNumberTextField.text else {
            errorLabel.showError(Constants.shortNumberLabelText)
            return
        }
        
        let cleanedPhone = phoneText.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if isPhoneNubmerInputValid {
            interactor.sendCodeRequest(
                SendCodeModels.SendCodeRequest(
                    phone: cleanedPhone)
            )
        } else {
            errorLabel.showError(Constants.shortNumberLabelText)
        }
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        let keyboardHeight = keyboardFrame.height

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
    func openTerms() {
        if let url = URL(string: Constants.linkTermAddress) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .formSheet
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    @objc
    func openPrivacy() {
        if let url = URL(string: Constants.linkPrivacyAddress) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .formSheet
            present(safariVC, animated: true, completion: nil)
        }
    }
    
    @objc
    func openContents() {
        if let url = URL(string: Constants.linkContentAddress) {
            let safariVC = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .formSheet
            present(safariVC, animated: true, completion: nil)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SendCodeViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // Получаем текущую позицию курсора
        if let selectedRange = textField.selectedTextRange {
            let cursorOffset = textField.offset(from: textField.beginningOfDocument, to: selectedRange.start)

            // Если курсор находится в диапазоне от 0 до 4, перемещаем его на позицию 4
            if cursorOffset < 4 && selectedRange.isEmpty {
                if let newPosition = textField.position(from: textField.beginningOfDocument, offset: 4) {
                    textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
                }
            }
        }
    }
}
