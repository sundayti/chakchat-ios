//
//  UserProfileScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//

import Foundation
import UIKit
final class UserProfileScreenViewController: UIViewController {
    
    private var titleLabel: UILabel = UILabel()
    private var iconImageView: UIImageView = UIImageView()
    private var userTableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var userTableViewData = [
        [("NamePlaceholder")],
        [("UsernamePlaceholder")],
        [("PhonePlaceholder")],
        [("BirthPlaceholder")]
    ]
    
    let interactor: UserProfileScreenBusinessLogic
    
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
    }
    
    public func configureUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        userTableViewData[0][0] = userData.nickname
        userTableViewData[1][0] = userData.username
        userTableViewData[2][0] = userData.phone
        if let icon = userData.photo {
            iconImageView.image = icon
        }
        if let birth = userData.dateOfBirth {
            userTableViewData[3][0] = birth.replacingOccurrences(of: "-", with: ".");
        }
    }
    
    public func updateUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        userTableViewData[0][0] = userData.nickname
        userTableViewData[1][0] = userData.username
        userTableViewData[2][0] = userData.phone
        if let icon = userData.photo {
            iconImageView.image = icon
        }
        if let birth = userData.dateOfBirth {
            userTableViewData[3][0] = birth.replacingOccurrences(of: "-", with: ".");
        }
        userTableView.reloadData()
    }
    
    private func configureUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonPressed))
        configureTitleLabel()
        navigationItem.titleView = titleLabel
        configureIcon()
        configureProfileTableView()
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB18
        titleLabel.text = "My profile"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
    }
    
    private func configureIcon() {
        view.addSubview(iconImageView)
        iconImageView.setHeight(100)
        iconImageView.setWidth(100)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.pinCenterX(view)
        iconImageView.pinTop(view.safeAreaLayoutGuide.topAnchor, 10)
        let config = UIImage.SymbolConfiguration(pointSize: 100, weight: .light, scale: .default)
        let gearImage = UIImage(systemName: "camera.circle", withConfiguration: config)
        iconImageView.tintColor = Colors.lightOrange
        iconImageView.image = gearImage
    }
    
    private func configureProfileTableView() {
        view.addSubview(userTableView)
        userTableView.delegate = self
        userTableView.dataSource = self
        userTableView.separatorStyle = .singleLine
        userTableView.separatorInset = .zero
        userTableView.isUserInteractionEnabled = false
        userTableView.pinHorizontal(view, -15)
        userTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 20)
        userTableView.pinTop(iconImageView.bottomAnchor, 20)
        userTableView.register(UserProfileCell.self, forCellReuseIdentifier: UserProfileCell.cellIdentifier)
        userTableView.backgroundColor = view.backgroundColor
    }
    
    @objc
    private func backButtonPressed() {
        interactor.backToSettingsMenu()
    }
    
    @objc
    private func editButtonPressed() {
        interactor.profileSettingsRoute()
    }
}

extension UserProfileScreenViewController: UITableViewDelegate, UITableViewDataSource {
    // if user dont pick his date of birth he/she will see only 3 sections in current screen
    func numberOfSections(in tableView: UITableView) -> Int {
        return userTableViewData[3][0] == "" ? 3 : 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserProfileCell.cellIdentifier, for: indexPath) as? UserProfileCell else {
            return UITableViewCell()
        }
        let item = userTableViewData[indexPath.section][indexPath.row]
        // если номер телефона
        switch indexPath.section {
        case 2:
            if let formatedPhone = Format.number(item) {
                cell.configure(with: formatedPhone)
            } else {
                cell.configure(with: item)
            }
        default:
            cell.configure(with: item)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        // вот эта штучка ответственна за то, где именно будет располагаться заголовок относительно секции
        label.frame = CGRect.init(x: 10, y: 0, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        // тут выбираем header для конкретной секции
        switch section {
        case 0:
            label.text = "Name"
        case 1:
            label.text = "Username"
        case 2:
            label.text = "Phone"
        case 3:
            label.text = "Date of birth"
        default:
            label.text = nil
        }
        label.textColor = .systemGray2
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 140))
        footerView.backgroundColor = .systemGray5
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
}

