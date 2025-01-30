//
//  ConfidentialityScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import UIKit
final class ConfidentialityScreenViewController: UIViewController {
    
    private lazy var confidentialitySettingsTable: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var confidentilitySection = [
        ("Phone number", "All"),
        ("Date of Birth", "All"),
        ("Online status", "All")
    ]
    private var blackListSection = [
        (UIImage(systemName: "person.crop.circle.badge.xmark"), "Black list", "10")
    ]
    
    let interactor: ConfidentialityScreenBusinessLogic
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    init(interactor: ConfidentialityScreenBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    public func configureSections(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        confidentilitySection[0].1 = userData.phoneNumberState.rawValue
        confidentilitySection[1].1 = userData.dateOfBirthState.rawValue
        confidentilitySection[2].1 = userData.onlineStatus.rawValue
    }
    
    public func updateVisibilityStatus(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        confidentilitySection[0].1 = userData.phoneNumberState.rawValue
        confidentilitySection[1].1 = userData.dateOfBirthState.rawValue
        confidentilitySection[2].1 = userData.onlineStatus.rawValue
        confidentialitySettingsTable.reloadData()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        interactor.loadUserData()
        configureSettingsTable()
  
    }
    
    private func configureSettingsTable() {
        view.addSubview(confidentialitySettingsTable)
        confidentialitySettingsTable.delegate = self
        confidentialitySettingsTable.dataSource = self
        confidentialitySettingsTable.separatorStyle = .singleLine
        confidentialitySettingsTable.pinHorizontal(view)
        confidentialitySettingsTable.pinTop(view.safeAreaLayoutGuide.topAnchor, 40)
        confidentialitySettingsTable.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 20)
        confidentialitySettingsTable.register(ConfidentialityMenuCell.self, forCellReuseIdentifier: ConfidentialityMenuCell.cellIdentifier)
        confidentialitySettingsTable.register(BlackListCell.self, forCellReuseIdentifier: BlackListCell.cellIdentifier)
        confidentialitySettingsTable.backgroundColor = view.backgroundColor
        
    }
    
    @objc
    private func backButtonPressed() {
        interactor.backToSettingsMenu()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ConfidentialityScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ConfidentialityMenuCell.cellIdentifier, for: indexPath) as? ConfidentialityMenuCell else {
                return UITableViewCell()
            }
            let item = confidentilitySection[indexPath.row]
            cell.configureSettings(title: item.0, status: item.1)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BlackListCell.cellIdentifier, for: indexPath) as? BlackListCell else {
                return UITableViewCell()
            }
            let item = blackListSection[indexPath.row]
            cell.configure(icon: item.0, title: item.1, amount: item.2)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            interactor.routeToPhoneVisibilityScreen()
        case (0,1):
            interactor.routeToBirthVisibilityScreen()
            break
        case (0,2):
            print("Route to online status screen")
            break
        case (1,0):
            print("Route to black list")
            break
        default:
            break
        }
    }
}
