//
//  ProfileSettingsViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit

// MARK: - ProfileSettingsViewController
final class ProfileSettingsViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var iconImageView: UIImageView = UIImageView()
    private var nicknameTextField: UITextField = UITextField()
    private var usernameTextField: UITextField = UITextField()
    let interactor: ProfileSettingsBusinessLogic
    
    // MARK: - Initialization
    init(interactor: ProfileSettingsBusinessLogic) {
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
    
    // MARK: - User Data Configuration
    public func configureUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        configureNicknameLabel(userData.nickname)
        configureUsernameLabel(userData.username)
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        configureTitleLabel()
        navigationItem.titleView = titleLabel
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = .orange
        configureIconImageView()
        interactor.loadUserData()
    }
    
    // MARK: - Title Label Configuration
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = "Account\nSettings"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
    }
    
    // MARK: - Icon ImageView Configuration
    private func configureIconImageView() {
        view.addSubview(iconImageView)
        iconImageView.setHeight(90)
        iconImageView.setWidth(90)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.pinCenterX(view)
        iconImageView.pinTop(view.safeAreaLayoutGuide.topAnchor, 20)
        iconImageView.image = UIImage(systemName: "person.circle")
    }
    
    // MARK: - Nickname Label Configuration
    private func configureNicknameLabel(_ nickname: String) {
        view.addSubview(nicknameTextField)
        nicknameTextField.text = nickname
        nicknameTextField.placeholder = "Nickname"
        nicknameTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nicknameTextField.setHeight(40)
        nicknameTextField.setWidth(300)
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.pinTop(iconImageView.bottomAnchor, 30)
        nicknameTextField.pinCenterX(view)
    }
    
    // MARK: - Username Label Configuration
    private func configureUsernameLabel(_ username: String) {
        view.addSubview(usernameTextField)
        usernameTextField.text = username
        usernameTextField.placeholder = "Username"
        usernameTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        usernameTextField.setHeight(40)
        usernameTextField.setWidth(300)
        usernameTextField.borderStyle = .roundedRect
        usernameTextField.pinTop(nicknameTextField.bottomAnchor, 15)
        usernameTextField.pinCenterX(view)
    }
    
    // MARK: - User Profile Data Transfering
    private func transferUserProfileData() -> ProfileSettingsModels.ProfileUserData {
        // if text == nil, disable apply button(in future :) )
        let newNickname = nicknameTextField.text ?? "default"
        let newUsername = usernameTextField.text ?? "default"
        return ProfileSettingsModels.ProfileUserData(nickname: newNickname, username: newUsername)
    }
    
    // MARK: - Actions
    @objc
    private func cancelButtonPressed() {
        interactor.backToSettingsMenu()
    }
    
    @objc
    private func applyButtonPressed() {
        let newData = transferUserProfileData()
        interactor.saveNewData(newData)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}
