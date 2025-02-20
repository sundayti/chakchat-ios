//
//  UserProfileScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//
import UIKit

// MARK: - UserProfileScreenViewController
final class UserProfileScreenViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let arrowName: String = "arrow.left"
        static let editButtonName: String = "Edit"
        static let titleText: String = "My profile"
        static let iconDefaultName: String = "camera.circle"
        static let iconSize: CGFloat = 100
        static let iconTop: CGFloat = 10
        static let nameLabelTop: CGFloat = 10
        static let userTableHorizontal: CGFloat = -15
        static let userTableBottom: CGFloat = 20
        static let userTableYop: CGFloat = 0
        static let estimateRowHeight: CGFloat = 60
    }
    
    // MARK: - Properties
    private var titleLabel: UILabel = UILabel()
    private var nameLabel: UILabel = UILabel()
    private var iconImageView: UIImageView = UIImageView()
    private var userTableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var userTableViewData: [(title: String, value: String)] = [
        ("Username", ""),
        ("Phone", ""),
        ("Date of Birth", "")
    ]
    
    let interactor: UserProfileScreenBusinessLogic
    
    // MARK: - Initialization
    init(interactor: UserProfileScreenBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor.loadUserData()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - User Data Configuration/Updating
    public func configureUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        nameLabel.text = userData.name
        userTableViewData[0].value = userData.username
        userTableViewData[1].value = userData.phone
        if let birth = userData.dateOfBirth {
            userTableViewData[2].value = birth
        }
        if let photoURL = userData.photo {
            if let image = interactor.unpackPhotoByUrl(photoURL) {
                iconImageView.image = image
            }
        }
    }
    
    public func updateUserData(_ userData: ProfileSettingsModels.ChangeableProfileUserData) {
        nameLabel.text = userData.name
        userTableViewData[0].value = userData.username
        if let birth = userData.dateOfBirth {
            userTableViewData[2].value = birth
        }
        if let photoURL = userData.photo {
            if let image = interactor.unpackPhotoByUrl(photoURL) {
                iconImageView.image = image
            }
        }
        userTableView.reloadData()
    }
    
    // MARK: - UI Confoguration
    private func configureUI() {
        configureBackButton()
        view.backgroundColor = Colors.backgroundSettings
        configureEditButton()
        configureTitleLabel()
        navigationItem.titleView = titleLabel
        configureIcon()
        configureNameLabel()
        configureProfileTableView()
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
    
    // MARK: - Edit Button Configuration
    private func configureEditButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.editButtonName, style: .plain, target: self, action: #selector(editButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = Colors.lightOrange
    }
    
    // MARK: - Title Label Configuration
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB18
        titleLabel.text = Constants.titleText
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
    }
    
    // MARK: - Icon Configuration
    private func configureIcon() {
        view.addSubview(iconImageView)
        iconImageView.setHeight(Constants.iconSize)
        iconImageView.setWidth(Constants.iconSize)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.pinCenterX(view)
        iconImageView.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.iconTop)
        let config = UIImage.SymbolConfiguration(pointSize: Constants.iconSize, weight: .light, scale: .default)
        let gearImage = UIImage(systemName: Constants.iconDefaultName, withConfiguration: config)
        iconImageView.tintColor = Colors.lightOrange
        iconImageView.image = gearImage
    }
    
    // MARK: - Name Label Configuration
    private func configureNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.font = Fonts.systemB20
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.pinTop(iconImageView.bottomAnchor, Constants.nameLabelTop)
        nameLabel.pinCenterX(view)
    }
    
    // MARK: - Profile Table Configuration
    private func configureProfileTableView() {
        view.addSubview(userTableView)
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.separatorStyle = .singleLine
        userTableView.separatorInset = .zero
        userTableView.isUserInteractionEnabled = false
        userTableView.pinHorizontal(view, Constants.userTableHorizontal)
        userTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, Constants.userTableBottom)
        userTableView.pinTop(nameLabel.bottomAnchor, Constants.userTableYop)
        userTableView.register(UserProfileCell.self, forCellReuseIdentifier: UserProfileCell.cellIdentifier)
        userTableView.backgroundColor = view.backgroundColor
        userTableView.rowHeight = UITableView.automaticDimension
        userTableView.estimatedRowHeight = Constants.estimateRowHeight
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        interactor.backToSettingsMenu()
    }
    
    @objc
    private func editButtonPressed() {
        interactor.profileSettingsRoute()
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UserProfileScreenViewController: UITableViewDelegate, UITableViewDataSource {
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

