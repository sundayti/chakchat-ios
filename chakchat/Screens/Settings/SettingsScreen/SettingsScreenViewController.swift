//
//  SettingsScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit

// MARK: - SettingsScreenViewController
final class SettingsScreenViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let iconImageSize: CGFloat = 80
        static let defaultProfileImageSymbol: String = "camera.circle"
        static let backArrowSymbol: String = "arrow.left"
        static let headerText: String = "Settings"
        static let iconTop: CGFloat = 10
        static let settingsTableHorizontal: CGFloat = -15
        static let settingsTableTop: CGFloat = 5
        static let settingsTableBottom: CGFloat = 20
        static let nicknameLabelTop: CGFloat = 10
        static let dotText: String = "•"
        static let atText: String = "@"
        static let dataStackViewSpacing: CGFloat = 10
        static let dataStackViewTop: CGFloat = 5
        static let tableHeaderHeight: CGFloat = 50
        static let tableHeaderX: CGFloat = 0
        static let tableHeaderY: CGFloat = 0
        static let tableLabelX: CGFloat = 15
        static let tableLabelY: CGFloat = 5
        static let tableLabelDifferenceToHeader: CGFloat = -10
        static let labelCase0: String = "User"
        static let labelCase1: String = "General"
        static let labelCase2: String = "App"
        static let labelCase3: String = "Support"
        static let labelFontSize: CGFloat = 12
        static let spaceBetweenSections: CGFloat = 30
    }
    
    // MARK: - Properties
    var interactor: SettingsScreenBusinessLogic

    private var settingsTableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var settingsLabel: UILabel = UILabel()
    private var nicknameLabel: UILabel = UILabel()
    private var usernameLabel: UILabel = UILabel()
    private var phoneLabel: UILabel = UILabel()
    private var dotLabel: UILabel = UILabel()
    private var editProfileButton: UIGradientButton = UIGradientButton(title: "Edit profile")
    private lazy var dataStackView: UIStackView = UIStackView(arrangedSubviews: [phoneLabel, dotLabel, usernameLabel])
    
    private let iconImageView: UIImageView = UIImageView()
    private let sections = [
        [("My profile", UIImage(systemName: "person.crop.circle"))],
        [("Confidentiality", UIImage(systemName: "lock")),
         ("Notifications", UIImage(systemName: "bell")),
         ("Devices", UIImage(systemName: "iphone.gen2.motion"))
        ],
        [("Data and Memory", UIImage(systemName: "memorychip")),
         ("App theme", UIImage(systemName: "cloud.moon.fill")),
         ("Language", UIImage(systemName: "globe.europe.africa.fill"))
        ],
        [("Help", UIImage(systemName: "questionmark.bubble"))]
    ]
    
    // MARK: - Initialization
    init(interactor: SettingsScreenBusinessLogic) {
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
    
    // MARK: - UserData Configuration
    public func configureUserData(_ data: ProfileSettingsModels.ProfileUserData) {
        // if user already loaded his data
        configureNicknameLabel(data.nickname)
        configureDataStackView(data.username, data.phone)
    }
    
    // MARK: - UserData Update
    public func updateUserData(_ data: ProfileSettingsModels.ChangeableProfileUserData) {
        nicknameLabel.text = data.nickname
        usernameLabel.text = data.username
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .white
        configureSettingsLabel()
        navigationItem.titleView = settingsLabel
        configureBackButton()
        configureIconImageView()
        interactor.loadUserData()
        configureSettingTableView()
    }
    
    // MARK: - Settings Label Configuration
    private func configureSettingsLabel() {
        view.addSubview(settingsLabel)
        settingsLabel.font = Fonts.systemB24
        settingsLabel.text = Constants.headerText
    }
    
    // MARK: - Back Button Configuration
    private func configureBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.backArrowSymbol), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    // MARK: - Icon ImageView Configuration
    private func configureIconImageView() {
        view.addSubview(iconImageView)
        iconImageView.setHeight(Constants.iconImageSize)
        iconImageView.setWidth(Constants.iconImageSize)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.pinCenterX(view)
        iconImageView.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.iconTop)
        
        let config = UIImage.SymbolConfiguration(pointSize: Constants.iconImageSize, weight: .light, scale: .default)
        let gearImage = UIImage(systemName: Constants.defaultProfileImageSymbol, withConfiguration: config)
        iconImageView.tintColor = Colors.lightOrange
        iconImageView.image = gearImage
    }
    
    // MARK: - Settings TableView Configuration
    private func configureSettingTableView() {
        view.addSubview(settingsTableView)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.separatorStyle = .singleLine
        settingsTableView.separatorInset = .zero
        settingsTableView.pinHorizontal(view, Constants.settingsTableHorizontal)
        settingsTableView.pinTop(dataStackView.bottomAnchor, Constants.settingsTableTop)
        settingsTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, Constants.settingsTableBottom)
        settingsTableView.register(SettingsMenuCell.self, forCellReuseIdentifier: SettingsMenuCell.cellIdentifier)
        settingsTableView.backgroundColor = view.backgroundColor
    }
    
    // MARK: - Nickname Label Confguration
    private func configureNicknameLabel(_ nickname: String) {
        view.addSubview(nicknameLabel)
        nicknameLabel.pinCenterX(view)
        nicknameLabel.pinTop(iconImageView.bottomAnchor, Constants.nicknameLabelTop)
        nicknameLabel.font = Fonts.systemSB20
        nicknameLabel.text = nickname
    }
    
    // MARK: - Data StackView Configuration
    private func configureDataStackView(_ username: String?, _ phone: String?) {
        view.addSubview(phoneLabel)
        view.addSubview(usernameLabel)
        view.addSubview(dotLabel)
        phoneLabel.font = Fonts.systemL14
        phoneLabel.text = Format.number(phone ?? "Загрузка...")
        phoneLabel.textColor = .gray
        phoneLabel.textAlignment = .center
        
        dotLabel.font = Fonts.systemB16
        dotLabel.text = Constants.dotText
        dotLabel.textColor = .gray
        dotLabel.textAlignment = .center
        
        usernameLabel.font = Fonts.systemL14
        usernameLabel.text = Constants.atText + (username ?? "Загрузка...")
        usernameLabel.textColor = .gray
        usernameLabel.textAlignment = .center
        
        view.addSubview(dataStackView)
        dataStackView.axis = .horizontal
        dataStackView.alignment = .center
        dataStackView.spacing = Constants.dataStackViewSpacing
        dataStackView.pinCenterX(view)
        dataStackView.pinTop(nicknameLabel.bottomAnchor, Constants.dataStackViewTop)
        
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table Header Configuration
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: Constants.tableHeaderX, y: Constants.tableHeaderY, width: tableView.frame.width, height: Constants.tableHeaderHeight))
        
        let label = UILabel()
        label.frame = CGRect.init(
            x: Constants.tableLabelX,
            y: Constants.tableLabelY,
            width: headerView.frame.width + Constants.tableLabelDifferenceToHeader,
            height: headerView.frame.height + Constants.tableLabelDifferenceToHeader
        )
        switch section {
        case 0:
            label.text = Constants.labelCase0
        case 1:
            label.text = Constants.labelCase1
        case 2:
            label.text = Constants.labelCase2
        case 3:
            label.text = Constants.labelCase3
        default:
            label.text = nil
        }
        label.font = .systemFont(ofSize: Constants.labelFontSize)
        label.textColor = .gray
        headerView.addSubview(label)
        return headerView
    }
    
    // MARK: - Setting Space between Sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.spaceBetweenSections
    }
    
    // MARK: - Setting Number of Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // MARK: - Number of lines in Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    // MARK: - Configuration and returning the cell for the specified index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingsCell = tableView.dequeueReusableCell(withIdentifier: SettingsMenuCell.cellIdentifier, for: indexPath) as? SettingsMenuCell
        else {
            return UITableViewCell()
        }
        let item = sections[indexPath.section][indexPath.row]
        settingsCell.configure(with: item.0, with: item.1)
        return settingsCell
    }
    
    // MARK: - Defining the behavior when a cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        // if pressed cell is "My Profile"
        case (0,0):
            interactor.profileSettingsRoute()
        // if pressed cell is "Confidentiality"
        case (1,0):
            interactor.confidentialitySettingsRoute()
        // if pressed cell is "Notification"
        case (1,1):
            interactor.notificationSettingsRoute()
        default:
            break
        }
    }
}
