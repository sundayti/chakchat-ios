//
//  GroupChatViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import UIKit

final class GroupChatViewController: UIViewController {
    
    // MARK: - Constants
    enum Constants {
        static let navigationItemHeight: CGFloat = 44
        static let borderWidth: CGFloat = 5
        static let cornerRadius: CGFloat = 22
        static let spacing: CGFloat = 12
        static let stackViewWidth: CGFloat = 300
        static let arrowName: String = "arrow.left"
        static let separatorTop: CGFloat = 10
        static let separatorHeight: CGFloat = 1
        static let separatorHorizontal: CGFloat = 0
        static let messageInputViewHorizontal: CGFloat = 8
        static let messageInputViewHeigth: CGFloat = 50
        static let messageInputViewBottom: CGFloat = 0
    }
    
    // MARK: - Properties
    private let interactor: GroupChatBusinessLogic
    private let messageInputView = MessageInputView()
    private let titleStackView: UIStackView = UIStackView()
    private let iconImageView: UIImageView = UIImageView()
    private let groupNameLabel: UILabel = UILabel()
    private let separator: UIView = UIView()
    private var tapGesture: UITapGestureRecognizer?
    
    // MARK: - Initialization
    init(interactor: GroupChatBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor.passChatData()
    }
    
    // MARK: - Changing image color
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            let color = UIColor.random()
            let image = UIImage.imageWithText(
                text: groupNameLabel.text ?? "",
                size: CGSize(width: Constants.navigationItemHeight, height:  Constants.navigationItemHeight),
                backgroundColor: Colors.background,
                textColor: color,
                borderColor: color,
                borderWidth: Constants.borderWidth
            )
            iconImageView.image = image
        }
    }
    
    // MARK: - Data Configuration
    func configureWithData(_ chatData: ChatsModels.GeneralChatModel.ChatData) {
        if case .group(let groupInfo) = chatData.info {
            let color = UIColor.random()
            let image = UIImage.imageWithText(
                text: groupInfo.name,
                size: CGSize(width: Constants.navigationItemHeight, height:  Constants.navigationItemHeight),
                backgroundColor: Colors.background,
                textColor: color,
                borderColor: color,
                borderWidth: Constants.borderWidth
            )
            iconImageView.image = image
            if let photoURL = groupInfo.groupPhoto {
                iconImageView.image = ImageCacheManager.shared.getImage(for: photoURL as NSURL)
                iconImageView.layer.cornerRadius = Constants.cornerRadius
            }
            groupNameLabel.text = groupInfo.name
        }
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Colors.background
        
        configureBackButton()
        configureIconImageView()
        configureNicknameLabel()
        configureTitleStackView()
        configureSeparator()
        configureMessageView()
    }
    
    // MARK: - Back Button Configuration
    private func configureBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.arrowName), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.text
        
        // Adding returning to previous screen with swipe.
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(backButtonPressed))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
        
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture?.delegate = self
        if let tapGesture = tapGesture {
            view.addGestureRecognizer(tapGesture)
        }
    }
    
    // MARK: - Icon Image View Configuration
    private func configureIconImageView() {
        iconImageView.layer.cornerRadius = Constants.cornerRadius
        iconImageView.clipsToBounds = true
        iconImageView.setWidth(Constants.navigationItemHeight)
        iconImageView.setHeight(Constants.navigationItemHeight)
    }
    
    // MARK: - Nuckname Label Configuration
    private func configureNicknameLabel() {
        groupNameLabel.font = Fonts.systemSB20
        groupNameLabel.textColor = Colors.text
    }
    
    // MARK: - Title Stack View Configuration
    private func configureTitleStackView() {
        titleStackView.addArrangedSubview(iconImageView)
        titleStackView.addArrangedSubview(groupNameLabel)
        titleStackView.axis = .horizontal
        titleStackView.spacing = Constants.spacing
        titleStackView.setHeight(Constants.navigationItemHeight)
        titleStackView.setWidth(Constants.stackViewWidth)
        navigationItem.titleView = titleStackView
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    // MARK: - Separator Configuration
    private func configureSeparator() {
        view.addSubview(separator)
        separator.backgroundColor = .orange
        separator.setHeight(Constants.separatorHeight)
        separator.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.separatorTop)
        separator.pinLeft(view.leadingAnchor, Constants.separatorHorizontal)
        separator.pinRight(view.trailingAnchor, Constants.separatorHorizontal)
    }
    
    // MARK: - Message View Configuration
    private func configureMessageView() {
        view.addSubview(messageInputView)
        messageInputView.interactor = interactor
        messageInputView.pinLeft(view.leadingAnchor, Constants.messageInputViewHorizontal)
        messageInputView.pinRight(view.trailingAnchor, Constants.messageInputViewHorizontal)
        messageInputView.setHeight(Constants.messageInputViewHeigth)
        messageInputView.bottomConstraint = messageInputView.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: Constants.messageInputViewBottom
        )
        messageInputView.bottomConstraint.isActive = true
    }
    
    // MARK: - Actions
    @objc private func backButtonPressed() {
        interactor.routeBack()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension GroupChatViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let touchPoint = touch.location(in: view)
        return !messageInputView.frame.contains(touchPoint)
    }
}
