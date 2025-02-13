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
    
    // MARK: - Constants
    private enum Constants {
        static let headerText: String = "Online Status"
        static let arrowName: String = "arrow.left"
        static let tableTop: CGFloat = 0
        static let tableBottom: CGFloat = 20
        static let label0Text: String = "Who can see my online status"
        static let label1Text: String = "Exceptions"
    }
    
    // MARK: - Properties
    private var selectedIndex: IndexPath?
    private var titleLabel: UILabel = UILabel()
    private var onlineVisibilityTable: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var onlineVisibilityData = [
        [("Everyone"), ("Only me"), ("Specified")],
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
        configureBackArrow()
        configureTitleLabel()
        navigationItem.titleView = titleLabel
        interactor.loadUserRestrictions()
        configurePhoneVisibilityTable()
    }
    
    // MARK: - Title Label Configuration
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB24
        titleLabel.text = Constants.headerText
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Back Arrow Configuration
    private func configureBackArrow() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.arrowName), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    // MARK: - Phone Visibility Table Configuration
    private func configurePhoneVisibilityTable() {
        view.addSubview(onlineVisibilityTable)
        onlineVisibilityTable.delegate = self
        onlineVisibilityTable.dataSource = self
        onlineVisibilityTable.separatorStyle = .singleLine
        onlineVisibilityTable.pinHorizontal(view)
        onlineVisibilityTable.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.tableTop)
        onlineVisibilityTable.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, Constants.tableBottom)
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
    
    private func transferRestriction() -> String {
        if let selectedIndex {
            switch selectedIndex.row {
            case 0:
                return "everyone"
            case 1:
                return "only_me"
            case 2:
                return "specified"
            default:
                break
            }
        }
        return "everyone"
    }
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        let onlineStatus = transferRestriction()
        interactor.backToConfidentialityScreen(onlineStatus)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OnlineVisibilityScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Mark Current Option
    // Called during screen configuration to check the box depending on the data in the user defaults storage
    public func markCurrentOption(_ onlineRestriction: OnlineVisibilityStatus) {
        var rowIndex: Int
        switch onlineRestriction.status{
        case "everyone":
            rowIndex = 0
        case "only_me":
            rowIndex = 1
        case "specified":
            rowIndex = 2
        default:
            rowIndex = 0
            break
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
        label.frame = CGRect.init(x: 10, y: 10, width: headerView.frame.width-10, height: headerView.frame.height-10)
        switch section {
        case 0:
            label.text = Constants.label0Text
        case 1:
            label.text = Constants.label1Text
        default:
            label.text = nil
        }
        label.font = Fonts.systemR16
        label.textColor = .gray
        headerView.addSubview(label)
        return headerView
    }
    
    // MARK: - Setting space between different section
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIConstants.ConfidentialitySpaceBetweenSections
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
        } else {
            // the logic of the second section has not yet been invented
        }
    }
}
