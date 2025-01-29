//
//  ConfidentialityScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import UIKit
final class ConfidentialityScreenViewController: UIViewController {
    
    let interactor: ConfidentialityScreenBusinessLogic
    private lazy var confidentialitySettingsTable: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private let sections = [
        [("Phone number", nil),
         ("Date of Birth", nil),
         ("Devices", nil)
        ],
        [("Black list", UIImage(systemName: "person.crop.circle.badge.xmark"))]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    init(interactor: ConfidentialityScreenBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureSettingsTable()
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
        confidentialityCell.configure(icon: item.1, title: item.0, status: "Status")
        return confidentialityCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
