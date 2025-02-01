//
//  NotificationScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import UIKit

// MARK: - NotificationScreenViewController
final class NotificationScreenViewController: UIViewController {
    
    // MARK: - Properties
    private var notificationTableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var notificationData = [
        [("Notification")],
        [("Sound"), ("Vibration")]
    ]
    let interactor: NotificationScreenBusinessLogic
    
    // MARK: - Initialization
    init(interactor: NotificationScreenBusinessLogic) {
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
    public func configureUserData(_ userData: NotificationScreenModels.NotificationStatus) {
        // configure notifications data
    }
    
    // MARK: - UI Configurtaion
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        interactor.loadUserData()
        configureNotificationTable()
    }
    
    // MARK: - Notification Table Configuration
    private func configureNotificationTable() {
        view.addSubview(notificationTableView)
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        notificationTableView.separatorStyle = .singleLine
        notificationTableView.pinHorizontal(view)
        notificationTableView.pinTop(view.safeAreaLayoutGuide.topAnchor, 20)
        notificationTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 40)
        notificationTableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.cellIndetifier)
        notificationTableView.backgroundColor = view.backgroundColor
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        interactor.backToSettingsMenu()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NotificationScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 2
    }
    
    // MARK: - Configuration and returning the cell for the specified index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.cellIndetifier, for: indexPath) as? NotificationCell else {
            return UITableViewCell()
        }
        let item = notificationData[indexPath.section][indexPath.row]
        cell.configure(title: item)
        return cell
    }
    
    // MARK: - Setting Header to each Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        // where exactly the title will be located relative to the section
        label.frame = CGRect.init(x: 10, y: 10, width: headerView.frame.width-10, height: headerView.frame.height-10)
        switch section {
        case 0:
            label.text = "General"
        case 1:
            label.text = "Notifications in app"
        default:
            label.text = nil
        }
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        headerView.addSubview(label)
        return headerView
    }
    
    // MARK: - Setting space between different section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
