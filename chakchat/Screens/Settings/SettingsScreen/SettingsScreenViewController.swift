//
//  SettingsScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit
final class SettingsScreenViewController: UIViewController {
    
    private var settingsTableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private let sections = [
        [("My profile", UIImage(systemName: "person.crop.circle"))],
        [("Confidentiality", UIImage(systemName: "lock")),
         ("Notifications", UIImage(systemName: "bell")),
         ("Devices", UIImage(systemName: "iphone"))
        ],
        [("Data and Memory", UIImage(systemName: "memorychip")),
         ("App theme", UIImage(systemName: "cloud.moon.fill")),
         ("Language", UIImage(systemName: "globe.europe.africa.fill"))
        ],
        [("Help", UIImage(systemName: "questionmark.bubble"))]
    ]
    private var settingsLabel: UILabel = UILabel()
    private var buttonLabel: UILabel = UILabel()
    private let iconImageView: UIImageView = UIImageView()
    private var nicknameLabel: UILabel = UILabel()
    private var usernameLabel: UILabel = UILabel()
    private var phoneLabel: UILabel = UILabel()
    private lazy var dataStackView: UIStackView = UIStackView(arrangedSubviews: [phoneLabel, usernameLabel])
    private var editProfileButton: UIGradientButton = UIGradientButton(title: "Edit profile")
    var interactor: SettingsScreenBusinessLogic
    
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
    // Methods for configuration by using UserDefaultsStorage
    public func configureUserData(_ data: SettingsScreenModels.UserData) {
        // if user already loaded his data
        configureNicknameLabel(data.nickname)
        configureDataStackView(data.username, data.phone)
    }
    
    public func updateUserData(_ data: SettingsScreenModels.UserData) {
        nicknameLabel.text = data.nickname
        usernameLabel.text = data.username
    }
    
    private func configureUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        configureSettingsLabel()
        configureButtonLabel()
        navigationItem.titleView = settingsLabel
        view.backgroundColor = .white
        configureIconImageView()
        interactor.loadUserData()
        configureSettingTableView()
    }
    
    private func configureSettingsLabel() {
        view.addSubview(settingsLabel)
        settingsLabel.text = "Settings"
        settingsLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        settingsLabel.textAlignment = .center
    }
    
    private func configureButtonLabel() {
        view.addSubview(buttonLabel)
        buttonLabel.text = "Edit profile"
        buttonLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        buttonLabel.textAlignment = .center
    }
    
    private func configureIconImageView() {
        view.addSubview(iconImageView)
        iconImageView.setHeight(90)
        iconImageView.setWidth(90)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.pinCenterX(view)
        iconImageView.pinTop(view.safeAreaLayoutGuide.topAnchor, 10)
        iconImageView.image = UIImage(systemName: "person.circle")
    }
    
    private func configureSettingTableView() {
        view.addSubview(settingsTableView)
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.separatorStyle = .singleLine
        settingsTableView.pinHorizontal(view)
        settingsTableView.pinTop(iconImageView.bottomAnchor, 60)
        settingsTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 20)
        settingsTableView.register(SettingsMenuCell.self, forCellReuseIdentifier: SettingsMenuCell.cellIdentifier)
        settingsTableView.backgroundColor = view.backgroundColor
    }
    
    // Here you can edit nickname data (under icon)
    private func configureNicknameLabel(_ nickname: String) {
        view.addSubview(nicknameLabel)
        nicknameLabel.pinCenterX(view)
        nicknameLabel.pinTop(iconImageView.bottomAnchor, 10)
        nicknameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        nicknameLabel.text = nickname
    }
    
    // Here you can edit user data (thing under avatar)
    private func configureDataStackView(_ username: String, _ phone: String) {
        view.addSubview(phoneLabel)
        view.addSubview(usernameLabel)
        phoneLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        phoneLabel.text = phone
        phoneLabel.textColor = .gray
        phoneLabel.textAlignment = .center
        
        usernameLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        usernameLabel.text = username
        usernameLabel.textColor = .gray
        usernameLabel.textAlignment = .center
        
        view.addSubview(dataStackView)
        dataStackView.axis = .horizontal
        dataStackView.alignment = .center
        dataStackView.spacing = 10  
        dataStackView.pinCenterX(view)
        dataStackView.pinTop(nicknameLabel.bottomAnchor, 10)
        
    }
    
    @objc
    private func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingsScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Configuring header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 15, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        switch section {
        case 1:
            label.text = "General"
        case 2:
            label.text = "App"
        case 3:
            label.text = "Help"
        default:
            label.text = nil
        }
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        headerView.addSubview(label)
        return headerView
    }
    
    // Space between section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let settingsCell = tableView.dequeueReusableCell(withIdentifier: SettingsMenuCell.cellIdentifier, for: indexPath) as? SettingsMenuCell
        else {
            return UITableViewCell()
        }
        let item = sections[indexPath.section][indexPath.row]
        settingsCell.configure(with: item.0, with: item.1!)
        return settingsCell
    }
    
    // Here we are detecting which settings button was pressed by user
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        // if pressed section is "My Profile"
        case (0,0):
            interactor.profileSettingsRoute()
        // if pressed section is "Confidentiality"
        case (1,0):
            interactor.confidentialitySettingsRoute()
        default:
            break
        }
    }
}
