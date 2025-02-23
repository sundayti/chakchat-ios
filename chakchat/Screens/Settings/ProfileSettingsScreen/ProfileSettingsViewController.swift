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
        static let iconImageViewTop: CGFloat = 0
        static let nameTop: CGFloat = 2
        static let usernameTop: CGFloat = 2.5
        static let phoneTop: CGFloat = 2.5
        static let fieldsLeading: CGFloat = 0
        static let fieldsTrailing: CGFloat = 0
        static let defaultText: String = "default"
        
        static let logOutButtonRadius: CGFloat = 18
        static let logOutButtonTop: CGFloat = 25
        static let logOutButtonHeight: CGFloat = 38
        static let logOutButtonWidth: CGFloat = 100
        static let logOutBorderWidth: CGFloat = 1
        
        static let dateButtonTop: CGFloat = 2.5
        static let dateButtonX: CGFloat = 20
        static let dateButtonHeight: CGFloat = 50
        
        static let birthTextFieldTop: CGFloat = 2.5
        static let birthTextFieldLeading: CGFloat = 0
        static let birthTextFieldTrailing: CGFloat = 0
        static let cornerRadius: CGFloat = 50
    }
    
    // MARK: - Properties
    private lazy var iconImageView: UIImageView = UIImageView()
    private var nameTextField: UIProfileTextField = UIProfileTextField(title: "name", placeholder: "name", isEditable: true)
    private var usernameTextField: UIProfileTextField = UIProfileTextField(title: "username", placeholder: "username", isEditable: true)
    private var phoneTextField: UIProfileTextField = UIProfileTextField(title: "phone", placeholder: "phone", isEditable: false)
    private var birthTextField: UIProfileTextField = UIProfileTextField(title: "date_of_birth", placeholder: "choose", isEditable: false)
    private var logOutButton: UIButton = UIButton(type: .system)
    private var dateButton: UIButton = UIButton(type: .system)
    private let dateFormatter: DateFormatter = DateFormatter()
    let interactor: ProfileSettingsScreenBusinessLogic
    private var selectedDate: Date?
    private var imageURL: URL?
    
    // MARK: - Initialization
    init(interactor: ProfileSettingsScreenBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: .languageDidChange, object: nil)
        interactor.loadUserData()
    }
    
    // MARK: - User Data Configuration
    public func configureUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        nameTextField.setText(userData.name)
        usernameTextField.setText(userData.username)
        let formattedPhone = Format.number(userData.phone)
        phoneTextField.setText(formattedPhone)
        if let birth = userData.dateOfBirth {
            dateFormatter.dateFormat = UIConstants.dateFormat
            selectedDate = dateFormatter.date(from: birth)
            birthTextField.setText(birth)
        }
        if let photoURL = userData.photo {
            if let image = interactor.unpackPhotoByUrl(photoURL) {
                iconImageView.image = image
                iconImageView.layer.cornerRadius = Constants.cornerRadius
            }
        }
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Colors.backgroundSettings
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        configureIconImageView(nil)
        configureNameTextField()
        configureUsernameTextField()
        configurePhoneTextField()
        configureBirthTextField()
        configureDateButton()
        
        configureCancelButton()
        configureApplyButton()
        configureLogOutButton()
    }
    
    // MARK: - Cancel Button Configuration
    private func configureCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: LocalizationManager.shared.localizedString(for: "cancel"), style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.lightOrange
    }
    
    // MARK: - Apply Button Configuration
    private func configureApplyButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: LocalizationManager.shared.localizedString(for: "apply"), style: .plain, target: self, action: #selector(applyButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = Colors.lightOrange
    }
    
    // MARK: - Icon ImageView Configuration
    private func configureIconImageView(_ image: UIImage?) {
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
        iconImageView.image = gearImage
        
        iconImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconImageViewTapped))
        iconImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Name Text Field Configuration
    private func configureNameTextField() {
        view.addSubview(nameTextField)
        nameTextField.pinTop(iconImageView.bottomAnchor, Constants.nameTop)
        nameTextField.pinLeft(view.leadingAnchor, Constants.fieldsLeading)
        nameTextField.pinRight(view.trailingAnchor, Constants.fieldsTrailing)
        nameTextField.setText(LocalizationManager.shared.localizedString(for: "error"))
    }
    
    // MARK: - Username Text Field Configuration
    private func configureUsernameTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.pinTop(nameTextField.bottomAnchor, Constants.usernameTop)
        usernameTextField.pinLeft(view.leadingAnchor, Constants.fieldsLeading)
        usernameTextField.pinRight(view.trailingAnchor, Constants.fieldsTrailing)
        usernameTextField.setText(LocalizationManager.shared.localizedString(for: "error"))
    }
    
    // MARK: - Phone Text Field Configuration
    private func configurePhoneTextField() {
        view.addSubview(phoneTextField)
        phoneTextField.pinTop(usernameTextField.bottomAnchor, Constants.phoneTop)
        phoneTextField.pinLeft(view.leadingAnchor, Constants.fieldsLeading)
        phoneTextField.pinRight(view.trailingAnchor, Constants.fieldsTrailing)
        phoneTextField.setText(LocalizationManager.shared.localizedString(for: "error"))
    }
    
    private func configureBirthTextField() {
        view.addSubview(birthTextField)
        birthTextField.pinTop(phoneTextField.bottomAnchor, Constants.birthTextFieldTop)
        birthTextField.pinLeft(view.leadingAnchor, Constants.birthTextFieldLeading)
        birthTextField.pinRight(view.trailingAnchor, Constants.birthTextFieldTrailing)
    }
    
    // MARK: - Log Out Button Configuration
    private func configureLogOutButton() {
        logOutButton.setTitle(LocalizationManager.shared.localizedString(for: "log_out"), for: .normal)
        logOutButton.setTitleColor(.systemRed, for: .normal)
        logOutButton.titleLabel?.font = Fonts.systemB20
        logOutButton.backgroundColor = .clear
        logOutButton.layer.cornerRadius = Constants.logOutButtonRadius
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
        dateButton.addTarget(self, action: #selector(dateButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - User Profile Data Transfering
    private func transferUserProfileData() throws -> ProfileSettingsModels.ChangeableProfileUserData {
        guard let newNickname = nameTextField.getText() else {
            throw CriticalError.noData
        }
        guard let newUsername = usernameTextField.getText() else {
            throw CriticalError.noData
        }
        let newBirth = birthTextField.getText()
        
        return ProfileSettingsModels.ChangeableProfileUserData(
            name: newNickname,
            username: newUsername,
            photo: imageURL,
            dateOfBirth: newBirth
        )
    }
    
    // MARK: - Actions
    @objc
    private func cancelButtonPressed() {
        interactor.backToSettingsMenu()
    }
    
    @objc
    private func applyButtonPressed() {
        do {
            let newData = try transferUserProfileData()
            interactor.saveNewData(newData)
        } catch CriticalError.noData {
            print("Critical error")
        } catch {
            print("Unknown error")
        }
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
        interactor.signOut()
    }
    
    @objc
    private func iconImageViewTapped() {
        // TODO: added screen with setting image
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc
    private func dateButtonPressed() {
        let datePicker: UICustomDatePicker = UICustomDatePicker()
        view.addSubview(datePicker)
        datePicker.pinTop(view.topAnchor, 0)
        datePicker.pinLeft(view.leadingAnchor, 0)
        datePicker.pinRight(view.trailingAnchor, 0)
        datePicker.pinBottom(view.bottomAnchor, 0)
        view.bringSubviewToFront(datePicker)
        datePicker.settedDate = selectedDate ?? Date()
        datePicker.title = LocalizationManager.shared.localizedString(for: "date_of_birth")
        datePicker.pinSuperView(view)
        datePicker.delegate = { [weak self] date in
            self?.handleDateSelection(date)
        }
    }
    
    // TODO: - Probably it is interactor logic
    private func handleDateSelection(_ date: Date?) {
        if let date = date {
            print("Selected Date: \(date)")
            dateFormatter.dateFormat = UIConstants.dateFormat
            let formattedDate = dateFormatter.string(from: date)
            selectedDate = date
            birthTextField.setText(formattedDate)
        } else {
            print("Date selection was reset")
            selectedDate = nil
            birthTextField.setText(nil)
        }
    }
    
    @objc
    private func languageDidChange() {
        navigationItem.rightBarButtonItem?.title = LocalizationManager.shared.localizedString(for: "apply")
        navigationItem.leftBarButtonItem?.title = LocalizationManager.shared.localizedString(for: "cancel")
        logOutButton.titleLabel?.text = LocalizationManager.shared.localizedString(for: "log_out")
        nameTextField.localize()
        usernameTextField.localize()
        phoneTextField.localize()
        birthTextField.localize()
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileSettingsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            if let pickedImageURL = interactor.saveImage(pickedImage) {
                imageURL = pickedImageURL // чтобы сохранить юрл для ивента
                print("Image saved in URL: \(pickedImageURL)")
                print("Image name is \(pickedImageURL.lastPathComponent)")
                print("MIME-type: image/\(pickedImageURL.pathExtension)")
                interactor.uploadImage(pickedImageURL, pickedImageURL.lastPathComponent, "image/png")
            }
            iconImageView.image = pickedImage
            iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

enum CriticalError: Error {
    case noData
}
