//
//  OnlineVisibilityScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import UIKit

// MARK: - OnlineVisibilityScreenViewController
final class OnlineVisibilityScreenViewController: UIViewController {
    
    // MARK: - Properties
    private var selectedIndex: IndexPath?
    private var onlineVisibilityTable: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var onlineVisibilityData = [
        [("All"), ("Custom"), ("Nobody")],
        [("Never show"), ("Always show")]
    ]
    let interactor: OnlineVisibilityScreenBusinessLogic
    
    // MARK: - Initialization
    init(interactor: OnlineVisibilityScreenBusinessLogic) {
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
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        interactor.loadUserData()
        configurePhoneVisibilityTable()
    }
    
    // MARK: - Phone Visibility Table Configuration
    private func configurePhoneVisibilityTable() {
        view.addSubview(onlineVisibilityTable)
        onlineVisibilityTable.delegate = self
        onlineVisibilityTable.dataSource = self
        onlineVisibilityTable.separatorStyle = .singleLine
        onlineVisibilityTable.pinHorizontal(view)
        onlineVisibilityTable.pinTop(view.safeAreaLayoutGuide.topAnchor, 20)
        onlineVisibilityTable.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 20)
        onlineVisibilityTable.register(VisibilityCell.self, forCellReuseIdentifier: VisibilityCell.cellIdentifier)
        onlineVisibilityTable.register(ExceptionsCell.self, forCellReuseIdentifier: ExceptionsCell.cellIdentifier)
        onlineVisibilityTable.backgroundColor = view.backgroundColor
    }
    
    // MARK: - Exceptions Section Updating
    // Edits the second section depending on what is selected in the first.
    private func updateExceptionsSection() {
        switch selectedIndex?.row {
        case 0:
            onlineVisibilityData[1] = [("Never show")]
        case 1:
            onlineVisibilityData[1] = [("Never show"), ("Always show")]
        case 2:
            onlineVisibilityData[1] = [("Always show")]
        default:
            break
        }
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        interactor.backToConfidentialityScreen()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OnlineVisibilityScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Mark Current Option
    // Called during screen configuration to check the box depending on the data in the user defaults storage
    public func markCurrentOption(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility) {
        var rowIndex: Int
        switch onlineVisibility.onlineStatus {
        case .all:
            rowIndex = 0
        case .custom:
            rowIndex = 1
        case .nobody:
            rowIndex = 2
        }
        selectedIndex = IndexPath(row: rowIndex, section: 0)
    }
    
    // MARK: - numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return onlineVisibilityData.count
    }
    
    // MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return onlineVisibilityData[section].count
    }
    
    // MARK: - Configuration and returning the cell for the specified index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VisibilityCell.cellIdentifier, for: indexPath) as? VisibilityCell else {
                return UITableViewCell()
            }
            let item = onlineVisibilityData[indexPath.section][indexPath.row]
            let isSelected = (indexPath == selectedIndex)
            cell.configure(title: item, isSelected: isSelected)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExceptionsCell.cellIdentifier, for: indexPath) as? ExceptionsCell else {
                return UITableViewCell()
            }
            let item = onlineVisibilityData[indexPath.section][indexPath.row]
            cell.configure(title: item)
            return cell
        }
    }
    
    // MARK: - Setting Header to each Section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        // where exactly the title will be located relative to the section
        label.frame = CGRect.init(x: 20, y: 10, width: headerView.frame.width-10, height: headerView.frame.height-10)
        switch section {
        case 0:
            label.text = "Who can see my online status"
        case 1:
            label.text = "Exceptions"
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
    
    // MARK: - Defining the behavior when a cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            if selectedIndex != indexPath {
                selectedIndex = indexPath
            }
            updateExceptionsSection()
            tableView.reloadData()
            switch indexPath.row {
            case 0:
                let newOnlineVisibility = OnlineVisibilityScreenModels.OnlineVisibility(onlineStatus: .all)
                interactor.saveNewData(newOnlineVisibility)
            case 1:
                let newOnlineVisibility = OnlineVisibilityScreenModels.OnlineVisibility(onlineStatus: .custom)
                interactor.saveNewData(newOnlineVisibility)
            case 2:
                let newOnlineVisibility = OnlineVisibilityScreenModels.OnlineVisibility(onlineStatus: .nobody)
                interactor.saveNewData(newOnlineVisibility)
            default:
                break
            }
        } else {
            // the logic of the second section has not yet been invented
        }
    }
}
