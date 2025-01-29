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
    private var sections = [
        [("Phone number", nil, "All"),
         ("Date of Birth", nil, "All"),
         ("Devices", nil, "All")
        ],
        [("Black list", UIImage(systemName: "person.crop.circle.badge.xmark"), "")]
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
        sections[0][0].2 = userData.phoneNumberState.rawValue // phone status
        sections[0][1].2 = userData.dateOfBirthState.rawValue // date of birth status
        sections[0][2].2 = userData.onlineStatus.rawValue // online status
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        configureSettingsTable()
        interactor.loadUserData()
    }
    
    private func configureSettingsTable() {
        view.addSubview(confidentialitySettingsTable)
        confidentialitySettingsTable.delegate = self
        confidentialitySettingsTable.dataSource = self
        confidentialitySettingsTable.separatorStyle = .singleLine
        confidentialitySettingsTable.pinHorizontal(view)
        confidentialitySettingsTable.pinTop(view.safeAreaLayoutGuide.topAnchor, 20)
        confidentialitySettingsTable.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 20)
        confidentialitySettingsTable.register(ConfidentialityMenuCell.self, forCellReuseIdentifier: ConfidentialityMenuCell.cellIdentifier)
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
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let confidentialityCell = tableView.dequeueReusableCell(withIdentifier: ConfidentialityMenuCell.cellIdentifier, for: indexPath) as? ConfidentialityMenuCell else {
            return UITableViewCell()
        }
        let item = sections[indexPath.section][indexPath.row]        
        confidentialityCell.configure(title: item.0, icon: item.1, status: item.2)
        return confidentialityCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
