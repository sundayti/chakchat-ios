//
//  GroupChatProfileViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.03.2025.
//

import UIKit

final class GroupChatProfileViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let configSize: CGFloat = 80
        static let borderWidth: CGFloat = 5
        static let cornerRadius: CGFloat = 50
        static let imageViewSize: CGFloat = 100
        static let imageViewTop: CGFloat = 10
        static let nicknameTop: CGFloat = 10
        static let arrowName: String = "arrow.left"
        static let borderRadius: CGFloat = 10
        static let buttonStackView: CGFloat = 10
        static let buttonWidth: CGFloat = 310
        static let buttonHeigth: CGFloat = 50
        static let buttonTop: CGFloat = 25
        static let userTableHorizontal: CGFloat = -15
        static let userTableBottom: CGFloat = 20
        static let userTableTop: CGFloat = 10
        static let userTableEstimateRow: CGFloat = 60
    }
    
    // MARK: - Properties
    private let interactor: GroupChatProfileBusinessLogic
    private let iconImageView: UIImageView = UIImageView()
    private let config = UIImage.SymbolConfiguration(pointSize: Constants.configSize, weight: .light, scale: .default)
    private let groupNameLabel: UILabel = UILabel()
    private let buttonStackView: UIStackView = UIStackView()
    
    // MARK: - Initialization
    init(interactor: GroupChatProfileBusinessLogic) {
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
                size: CGSize(width: Constants.configSize, height: Constants.configSize),
                backgroundColor: Colors.backgroundSettings,
                textColor: color,
                borderColor: color,
                borderWidth: Constants.borderWidth
            )
            iconImageView.image = image
        }
    }
    
    // MARK: - User Data Configuration
    func configureWithUserData(_ chatData: ChatsModels.GroupChat.Response) {
        let color = UIColor.random()
        let image = UIImage.imageWithText(
            text: chatData.name,
            size: CGSize(width: Constants.configSize, height: Constants.configSize),
            backgroundColor: Colors.backgroundSettings,
            textColor: color,
            borderColor: color,
            borderWidth: Constants.borderWidth
        )
        iconImageView.image = image
        if let photoURL = chatData.groupPhoto {
            iconImageView.image = ImageCacheManager.shared.getImage(for: photoURL as NSURL)
            iconImageView.layer.cornerRadius = Constants.cornerRadius
        }
        groupNameLabel.text = chatData.name
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Colors.backgroundSettings
        
        configureBackButton()
        configureIconImageView()
        configureInitials()
        configureButtonStackView()
        
    }
    
    // MARK: - Back Button Configuration
    private func configureBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.arrowName), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.text
        
        // Adding returning to previous screen with swipe.
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(backButtonPressed))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    // MARK: - Icon Image View Configuration
    private func configureIconImageView() {
        view.addSubview(iconImageView)
        iconImageView.setHeight(Constants.imageViewSize)
        iconImageView.setWidth(Constants.imageViewSize)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = Constants.cornerRadius
        iconImageView.layer.masksToBounds = true
        iconImageView.pinCenterX(view)
        iconImageView.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.imageViewTop)
        let gearImage = UIImage(systemName: "camera.circle", withConfiguration: config)
        iconImageView.tintColor = Colors.lightOrange
        iconImageView.image = gearImage
    }
    
    // MARK: - Initials Configuration
    private func configureInitials() {
        view.addSubview(groupNameLabel)
        groupNameLabel.font = Fonts.systemSB20
        groupNameLabel.textColor = Colors.text
        groupNameLabel.pinTop(iconImageView.bottomAnchor, Constants.nicknameTop)
        groupNameLabel.pinCenterX(view)
    }
    
    // MARK: - Button Stack View Configuration
    private func configureButtonStackView() {
        view.addSubview(buttonStackView)
        let createButton: (String, String) -> UIButton = { systemName, title in
            let button = UIUserProfileButton()
            button.configure(withSymbol: systemName, title: title)
            button.backgroundColor = Colors.userButtons
            button.tintColor = .orange
            button.setTitleColor(.orange, for: .normal)
            button.layer.cornerRadius = Constants.borderRadius
            
            return button
        }
        
        let notificationButton = createButton("bell.badge.fill",
                                              LocalizationManager.shared.localizedString(for: "sound_l"))
        let secretChatButton = createButton("key.fill",
                                            LocalizationManager.shared.localizedString(for: "secret_chat_l"))
        let searchButton = createButton("magnifyingglass",
                                        LocalizationManager.shared.localizedString(for: "search_l"))
        let optionsButton = createButton("ellipsis",
                                         LocalizationManager.shared.localizedString(for: "more_l"))
        
        buttonStackView.addArrangedSubview(notificationButton)
        buttonStackView.addArrangedSubview(secretChatButton)
        buttonStackView.addArrangedSubview(searchButton)
        buttonStackView.addArrangedSubview(optionsButton)
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = Constants.buttonStackView
        buttonStackView.setWidth(Constants.buttonWidth)
        buttonStackView.setHeight(Constants.buttonHeigth)
        buttonStackView.pinTop(groupNameLabel.bottomAnchor, Constants.buttonTop)
        buttonStackView.pinCenterX(view)
    }
    
    @objc private func backButtonPressed() {
        interactor.routeBack()
    }
}
