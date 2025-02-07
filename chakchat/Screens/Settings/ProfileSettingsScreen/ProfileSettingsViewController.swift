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
    
    // MARK: - Constants
    private enum Constants {
        static let defaultProfileImageSymbol: String = "camera.circle"
        static let iconImageSize: CGFloat = 100
        static let headerText: String = "Account\nSettings"
        static let iconImageViewTop: CGFloat = 20
        static let nicknamePlaceholder: String = "Nickname"
        static let titleNumberOfLines: Int = 2
        static let cancelButtonTitle: String = "Cancel"
        static let applyButtonTitle: String = "Apply"
        static let nameTop: CGFloat = 2
        static let usernameTop: CGFloat = 2.5
        static let phoneTop: CGFloat = 2.5
        static let fieldsLeading: CGFloat = 0
        static let fieldsTrailing: CGFloat = 0
        static let defaultText: String = "default"
        
        static let logOutButtonRadious: CGFloat = 18
        static let logOutButtonTitle: String = "Log out"
        static let logOutButtonTop: CGFloat = 25
        static let logOutButtonHeight: CGFloat = 38
        static let logOutButtonWidth: CGFloat = 100
        static let logOutBorderWidth: CGFloat = 1
        
        static let dateButtonTop: CGFloat = 2.5
        static let dateButtonX: CGFloat = 20
        static let dateButtonHeight: CGFloat = 50
    }
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var iconImageView: UIImageView = UIImageView()
    private lazy var phone: String = String()
    private var nameTextField: UIProfileTextField = UIProfileTextField(title: "Name", placeholder: "Name", isEditable: true)
    private var usernameTextField: UIProfileTextField = UIProfileTextField(title: "Username", placeholder: "Username", isEditable: true)
    private var phoneTextField: UIProfileTextField = UIProfileTextField(title: "Phone", placeholder: "Phone", isEditable: false)
    private var logOutButton: UIButton = UIButton()
    private var dateButton = UIDateButton()
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
        configureNameTextField(userData.nickname)
        configureUsernameTextField(userData.username)
        configurePhoneTextField(userData.phone)
        configureIconImageView(userData.icon)
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        configureTitleLabel()
        navigationItem.titleView = titleLabel
        configureCancelButton()
        configureApplyButton()
        configureIconImageView()
        interactor.loadUserData()
        configureDateButton()
        configureLogOutButton()
    }
    
    // MARK: - Cancel Button Configuration
    private func configureCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.cancelButtonTitle, style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.lightOrange
    }
    
    // MARK: - Apply Button Configuration
    private func configureApplyButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.applyButtonTitle, style: .plain, target: self, action: #selector(applyButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = Colors.lightOrange
    }
    
    // MARK: - Title Label Configuration
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB18
        titleLabel.text = Constants.headerText
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = Constants.titleNumberOfLines
    }
    
    // MARK: - Icon ImageView Configuration
    private func configureIconImageView(_ image: UIImage? = nil) {
        view.addSubview(iconImageView)
        iconImageView.setHeight(Constants.iconImageSize)
        iconImageView.setWidth(Constants.iconImageSize)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.layer.masksToBounds = true
        
        iconImageView.pinCenterX(view)
        iconImageView.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.iconImageViewTop)
        
        let config = UIImage.SymbolConfiguration(pointSize: Constants.iconImageSize, weight: .light, scale: .default)
        let gearImage = UIImage(systemName: Constants.defaultProfileImageSymbol, withConfiguration: config)
        iconImageView.tintColor = Colors.lightOrange
        iconImageView.image = image ?? gearImage
        
        iconImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconImageViewTapped))
        iconImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Name Text Field Configuration
    private func configureNameTextField(_ name: String) {
        view.addSubview(nameTextField)
        nameTextField.pinTop(iconImageView.bottomAnchor, Constants.nameTop)
        nameTextField.pinLeft(view.leadingAnchor, Constants.fieldsLeading)
        nameTextField.pinRight(view.trailingAnchor, Constants.fieldsTrailing)
        nameTextField.setText(name)
    }
    
    // MARK: - Username Text Field Configuration
    private func configureUsernameTextField(_ username: String) {
        view.addSubview(usernameTextField)
        usernameTextField.pinTop(nameTextField.bottomAnchor, Constants.usernameTop)
        usernameTextField.pinLeft(view.leadingAnchor, Constants.fieldsLeading)
        usernameTextField.pinRight(view.trailingAnchor, Constants.fieldsTrailing)
        usernameTextField.setText(username)
    }
    
    // MARK: - Phone Text Field Configuration
    private func configurePhoneTextField(_ phone: String) {
        view.addSubview(phoneTextField)
        phoneTextField.pinTop(usernameTextField.bottomAnchor, Constants.phoneTop)
        phoneTextField.pinLeft(view.leadingAnchor, Constants.fieldsLeading)
        phoneTextField.pinRight(view.trailingAnchor, Constants.fieldsTrailing)
        phoneTextField.setText(Format.number(phone) ?? Constants.defaultText)
    }
    
    // MARK: - Log Out Button Configuration
    private func configureLogOutButton() {
        logOutButton.setTitle(Constants.logOutButtonTitle, for: .normal)
        logOutButton.setTitleColor(.systemRed, for: .normal)
        logOutButton.titleLabel?.font = Fonts.systemB20
        logOutButton.backgroundColor = .clear
        logOutButton.layer.cornerRadius = Constants.logOutButtonRadious
        logOutButton.layer.borderWidth = Constants.logOutBorderWidth
        logOutButton.layer.borderColor = UIColor.systemRed.cgColor
        logOutButton.addTarget(self, action: #selector(logOutButtonPressed), for: .touchUpInside)
        logOutButton.setHeight(Constants.logOutButtonHeight)
        logOutButton.setWidth(Constants.logOutButtonWidth)
        
        view.addSubview(logOutButton)
        logOutButton.pinCenterX(view)
        logOutButton.pinTop(dateButton.bottomAnchor, Constants.logOutButtonTop)
    }
    
    // MARK: - Date Button Configuration
    private func configureDateButton() {
        view.addSubview(dateButton)
        dateButton.pinTop(phoneTextField.bottomAnchor, Constants.dateButtonTop)
        dateButton.pinLeft(view.leadingAnchor, Constants.dateButtonX)
        dateButton.pinRight(view.trailingAnchor, Constants.dateButtonX)
        dateButton.setHeight(Constants.dateButtonHeight)
    }
    
    // MARK: - User Profile Data Transfering
    private func transferUserProfileData() -> ProfileSettingsModels.ProfileUserData {
        // TODO: if text == nil, disable apply button(in future :) )
        let newNickname = nameTextField.getText() ?? Constants.defaultText
        let newUsername = usernameTextField.getText() ?? Constants.defaultText
        let newIcon = iconImageView.image ?? nil
        // TODO: add icon saving
        return ProfileSettingsModels.ProfileUserData(nickname: newNickname, username: newUsername, phone: phone, icon: newIcon)
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
    
    @objc
    private func logOutButtonPressed() {
        // TODO: show alert "Are u sure?" and log out of from account.
        UIView.animate(withDuration: UIConstants.animationDuration, animations: {
            self.logOutButton.transform = CGAffineTransform(scaleX: UIConstants.buttonScale, y: UIConstants.buttonScale)
            }, completion: { _ in
            UIView.animate(withDuration: UIConstants.animationDuration) {
                self.logOutButton.transform = CGAffineTransform.identity
            }
        })
    }
    
    @objc
    private func iconImageViewTapped() {
        // TODO: added screen with setting image
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileSettingsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            iconImageView.image = pickedImage
            iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension UIViewController {
    func askDate(title: String, settedDate: Date, delegate: @escaping (_ date: Date?) -> Void) {
        _ = UICustomDatePicker.createAndShow(in: self, title: title, settedDate: settedDate, delegate: delegate)
    }
}
