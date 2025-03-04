//
//  ChatViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit

final class ChatViewController: UIViewController {
    
    enum Constants {
        static let navigationItemHeight: CGFloat = 44
    }
    
    let interactor: ChatBusinessLogic
    private let messageInputView = MessageInputView()
    private let titleStackView: UIStackView = UIStackView()
    private let iconImageView: UIImageView = UIImageView()
    private let nicknameLabel: UILabel = UILabel()
    private let separator: UIView = UIView()
    private var tapGesture: UITapGestureRecognizer?
    
    init(interactor: ChatBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor.passUserData()
    }
    
    public func configureWithData(_ userData: ProfileSettingsModels.ProfileUserData) {
        let color = UIColor.random()
        let image = UIImage.imageWithText(
            text: LocalizationManager.shared.localizedString(for: userData.name),
            size: CGSize(width: Constants.navigationItemHeight, height:  Constants.navigationItemHeight),
            backgroundColor: Colors.background,
            textColor: color,
            borderColor: color,
            borderWidth: 5
        )
        iconImageView.image = image
        if let photoURL = userData.photo {
            iconImageView.image = ImageCacheManager.shared.getImage(for: photoURL as NSURL)
            iconImageView.layer.cornerRadius = 22
        }
        nicknameLabel.text = userData.name
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.text
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture?.delegate = self
        if let tapGesture = tapGesture {
            view.addGestureRecognizer(tapGesture)
        }
        configureIconImageView()
        configureNicknameLabel()
        configureTitleStackView()
        configureSeparator()
        configureMessageView()
    }
    
    private func configureIconImageView() {
        iconImageView.layer.cornerRadius = 22
        iconImageView.clipsToBounds = true
        iconImageView.setWidth(Constants.navigationItemHeight)
        iconImageView.setHeight(Constants.navigationItemHeight)
    }
    
    private func configureNicknameLabel() {
        nicknameLabel.font = Fonts.systemSB20
        nicknameLabel.textColor = Colors.text
    }
    
    private func configureTitleStackView() {
        titleStackView.addArrangedSubview(iconImageView)
        titleStackView.addArrangedSubview(nicknameLabel)
        titleStackView.axis = .horizontal
        titleStackView.spacing = 12
        titleStackView.setHeight(Constants.navigationItemHeight)
        titleStackView.setWidth(300)
        navigationItem.titleView = titleStackView
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    private func configureSeparator() {
        view.addSubview(separator)
        separator.backgroundColor = .orange
        separator.setHeight(1)
        separator.pinTop(view.safeAreaLayoutGuide.topAnchor, 10)
        separator.pinLeft(view.leadingAnchor, 0)
        separator.pinRight(view.trailingAnchor, 0)
    }
    
    
    private func configureMessageView() {
        view.addSubview(messageInputView)
        messageInputView.pinLeft(view.leadingAnchor, 8)
        messageInputView.pinRight(view.trailingAnchor, 8)
        messageInputView.setHeight(50)
        messageInputView.bottomConstraint = messageInputView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: 0
        )
        messageInputView.bottomConstraint.isActive = true
    }
    
    @objc private func backButtonPressed() {
        interactor.routeBack()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

class MessageInputView: UIView {
    private let textField = UITextField()
    private let sendButton = UIButton()
    var bottomConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureKeyboardObservers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .systemGray6
        layer.cornerRadius = 18
        
        textField.placeholder = "Type here..."
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        sendButton.setImage(UIImage(systemName: "arrow.up.circle.fill"), for: .normal)
        sendButton.tintColor = .systemBlue
        sendButton.alpha = 0
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        
        addSubview(textField)
        addSubview(sendButton)
        
        textField.pinLeft(leadingAnchor, 16)
        textField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8).isActive = true
        textField.pinTop(topAnchor, 8)
        textField.pinBottom(bottomAnchor, 8)
        
        sendButton.pinRight(trailingAnchor, 8)
        sendButton.pinCenterY(centerYAnchor)
        sendButton.setWidth(40)
        sendButton.setHeight(40)
        sendButton.imageView?.setWidth(40)
        sendButton.imageView?.setHeight(40)
    }
    
    private func configureKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        let keyboardHeight = keyboardFrame.cgRectValue.height
        bottomConstraint?.constant = -keyboardHeight
        
        UIView.animate(withDuration: duration) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        bottomConstraint?.constant = 0
        
        UIView.animate(withDuration: duration) {
            self.superview?.layoutIfNeeded()
        }
    }
    
    @objc private func textFieldDidChange() {
        let hasText = !(textField.text?.isEmpty ?? true)
        if hasText {
            UIView.animate(withDuration: 0.2) {
                self.sendButton.alpha = 1
            }
            if #available(iOS 17.0, *) {
                sendButton.imageView?.addSymbolEffect(.appear)
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.sendButton.alpha = 0
            }
        }
    }
    
    @objc private func sendMessage() {
        guard let text = textField.text, !text.isEmpty else { return }
        print("Sending message:", text)
        textField.text = nil
        sendButton.alpha = 0
    }
}

extension MessageInputView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        DispatchQueue.main.async {
            let newPosition = textField.endOfDocument
            textField.selectedTextRange = textField.textRange(from: newPosition, to: newPosition)
        }
        sendButton.alpha = textField.text?.isEmpty == false ? 1 : 0
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.clearsOnInsertion = false
        textField.clearsOnBeginEditing = false
        return true
    }
}

extension ChatViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: view)
        return !messageInputView.frame.contains(touchPoint)
    }
}
