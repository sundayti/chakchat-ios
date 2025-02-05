//
//  ConfidentialityScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import UIKit

// MARK: - ConfidentialityScreenViewController
final class ConfidentialityScreenViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let headerText: String = "Confidentiality"
    }
    
    // MARK: - Properties
    private var titleLabel: UILabel = UILabel()
    private lazy var confidentialitySettingsTable: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var confidentilitySection = [
        ("Phone number", "All"),
        ("Date of Birth", "All"),
        ("Online status", "All"),
        ("Black list", "10")
    ]
    
    let interactor: ConfidentialityScreenBusinessLogic
    
    // MARK: - Initialization
    init(interactor: ConfidentialityScreenBusinessLogic) {
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
    
    // MARK: - Sections Configurations
    public func configureSections(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        confidentilitySection[0].1 = userData.phoneNumberState.rawValue
        confidentilitySection[1].1 = userData.dateOfBirthState.rawValue
        confidentilitySection[2].1 = userData.onlineStatus.rawValue
    }
    
    // MARK: - Visibility Status Updating
    public func updateVisibilityStatus(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        confidentilitySection[0].1 = userData.phoneNumberState.rawValue
        confidentilitySection[1].1 = userData.dateOfBirthState.rawValue
        confidentilitySection[2].1 = userData.onlineStatus.rawValue
        confidentialitySettingsTable.reloadData()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .white
        configureBackArrow()
        interactor.loadUserData()
        configureSettingsTable()
        configureTitleLabel()
        navigationItem.titleView = titleLabel
    }
    // MARK: - Title Label Configuration
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB24
        titleLabel.text = Constants.headerText
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Setting Table Configuration
    private func configureSettingsTable() {
        view.addSubview(confidentialitySettingsTable)
        confidentialitySettingsTable.delegate = self
        confidentialitySettingsTable.dataSource = self
        confidentialitySettingsTable.separatorStyle = .singleLine
        confidentialitySettingsTable.separatorInset = .zero
        confidentialitySettingsTable.pinHorizontal(view)
        confidentialitySettingsTable.pinTop(view.safeAreaLayoutGuide.topAnchor, 0)
        confidentialitySettingsTable.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 20)
        confidentialitySettingsTable.register(ConfidentialityMenuCell.self, forCellReuseIdentifier: ConfidentialityMenuCell.cellIdentifier)
        confidentialitySettingsTable.register(BlackListCell.self, forCellReuseIdentifier: BlackListCell.cellIdentifier)
        confidentialitySettingsTable.backgroundColor = view.backgroundColor
    }
    
    // MARK: - Back Arrow Configuration
    private func configureBackArrow() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        interactor.backToSettingsMenu()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ConfidentialityScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    // MARK: - Configuration and returning the cell for the specified index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConfidentialityMenuCell.cellIdentifier, for: indexPath) as? ConfidentialityMenuCell else {
            return UITableViewCell()
        }
        let item = confidentilitySection[indexPath.row]
        cell.configureSettings(title: item.0, status: item.1)
        return cell
    }
    
    // MARK: - Defining the behavior when a cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (0,0):
            interactor.routeToPhoneVisibilityScreen()
        case (0,1):
            interactor.routeToBirthVisibilityScreen()
            break
        case (0,2):
            interactor.routeToOnlineVisibilityScreen()
            break
        case (0,3):
            print("Route to black list")
            break
        default:
            break
        }
    }
}
