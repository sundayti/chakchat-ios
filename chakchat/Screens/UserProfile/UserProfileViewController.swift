//
//  UserProfileViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit

final class UserProfileViewController: UIViewController {
    private let interactor: UserProfileBusinessLogic
    private let iconImageView: UIImageView = UIImageView()
    private let config = UIImage.SymbolConfiguration(pointSize: 80, weight: .light, scale: .default)
    private let nicknameLabel: UILabel = UILabel()
    private let buttonStackView: UIStackView = UIStackView()
    private let userDataTable: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var userTableViewData: [(title: String, value: String)] = [
        (LocalizationManager.shared.localizedString(for: "username"), ""),
        (LocalizationManager.shared.localizedString(for: "phone"), ""),
        (LocalizationManager.shared.localizedString(for: "date_of_birth"), "")
    ]
    
    init(interactor: UserProfileBusinessLogic) {
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
    //
    public func configureWithUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        let color = UIColor.random()
        let image = UIImage.imageWithText(
            text: LocalizationManager.shared.localizedString(for: userData.name),
            size: CGSize(width: 80, height: 80),
            backgroundColor: Colors.background,
            textColor: color,
            borderColor: color,
            borderWidth: 5
        )
        iconImageView.image = image
        if let photoURL = userData.photo {
            iconImageView.image = ImageCacheManager.shared.getImage(for: photoURL as NSURL)
            iconImageView.layer.cornerRadius = 50
        }
        nicknameLabel.text = userData.name
        userTableViewData[0].value = userData.username
        userTableViewData[1].value = Format.number(userData.phone) ?? ""
        if let birth = userData.dateOfBirth {
            userTableViewData[2].value = birth
        }
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.backgroundSettings
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.text
        configureIconImageView()
        configureInitials()
        configureButtonStackView()
        configureUserDataTable()
    }
    
    private func configureIconImageView() {
        view.addSubview(iconImageView)
        iconImageView.setHeight(100)
        iconImageView.setWidth(100)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = 50
        iconImageView.layer.masksToBounds = true
        iconImageView.pinCenterX(view)
        iconImageView.pinTop(view.safeAreaLayoutGuide.topAnchor, 10)
        let gearImage = UIImage(systemName: "camera.circle", withConfiguration: config)
        iconImageView.tintColor = Colors.lightOrange
        iconImageView.image = gearImage
        
    }
    
    private func configureInitials() {
        view.addSubview(nicknameLabel)
        nicknameLabel.font = Fonts.systemSB20
        nicknameLabel.textColor = Colors.text
        nicknameLabel.pinTop(iconImageView.bottomAnchor, 10)
        nicknameLabel.pinCenterX(view)
    }
    
    private func configureButtonStackView() {
        view.addSubview(buttonStackView)
        let createButton: (String) -> UIButton = { systemName in
            let button = UIButton(type: .system)
            button.backgroundColor = .white
            button.setImage(UIImage(systemName: systemName), for: .normal)
            button.tintColor = .orange
            button.setTitleColor(.orange, for: .normal)
            button.layer.cornerRadius = 10
            return button
        }
        
        let chatButton = createButton("message.fill")
        chatButton.addTarget(self, action: #selector(chatButtonPressed), for: .touchUpInside)
        let notificationButton = createButton("bell.badge.fill")
        let secretChatButton = createButton("lock.fill")
        let searchButton = createButton("magnifyingglass")
        
        buttonStackView.addArrangedSubview(chatButton)
        buttonStackView.addArrangedSubview(notificationButton)
        buttonStackView.addArrangedSubview(secretChatButton)
        buttonStackView.addArrangedSubview(searchButton)
        
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.setWidth(306)
        buttonStackView.setHeight(69)
        buttonStackView.pinTop(nicknameLabel.bottomAnchor, 25)
        buttonStackView.pinCenterX(view)
    }
    
    private func configureUserDataTable() {
        view.addSubview(userDataTable)
        userDataTable.delegate = self
        userDataTable.dataSource = self
        userDataTable.separatorStyle = .singleLine
        userDataTable.separatorInset = .zero
        userDataTable.isUserInteractionEnabled = false
        userDataTable.pinHorizontal(view, -15)
        userDataTable.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 20)
        userDataTable.pinTop(buttonStackView.bottomAnchor, 10)
        userDataTable.register(UserProfileCell.self, forCellReuseIdentifier: UserProfileCell.cellIdentifier)
        userDataTable.backgroundColor = view.backgroundColor
        userDataTable.rowHeight = UITableView.automaticDimension
        userDataTable.estimatedRowHeight = 60
    }
    
    @objc private func chatButtonPressed() {
        interactor.searchForExistingChat()
    }
    
    @objc private func backButtonPressed() {
        interactor.routeBack()
    }
}

extension UserProfileViewController: UITableViewDelegate, UITableViewDataSource {
    // if user dont pick his date of birth he/she will see only 3 sections in current screen
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTableViewData[2].value == "" ? 2 : 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileCell.cellIdentifier, for: indexPath) as? UserProfileCell else {
            return UITableViewCell()
        }
        let item = userTableViewData[indexPath.row]
        
        // if it's phone number -> formatting
        if item.title == "Phone", let formattedPhone = Format.number(item.value) {
            cell.configure(with: item.title, value: formattedPhone)
        } else {
            cell.configure(with: item.title, value: item.value)
        }
        
        return cell
    }
}
