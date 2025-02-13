//
//  PhoneVisibilityScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit

// MARK: - PhoneVisibilityScreenViewController
final class PhoneVisibilityScreenViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let headerText: String = "Phone number"
        static let arrowName: String = "arrow.left"
        static let tableTop: CGFloat = 0
        static let tableBottom: CGFloat = 40
        static let neverText: String = "Never show"
        static let alwaysText: String = "Always show"
        static let whoCanSeeLabelText: String = "Who can see my phone number"
        static let exceptionsLabelText: String = "Exceptions"
    }
    
    // MARK: - Properties
    private var selectedIndex: IndexPath?
    private var titleLabel: UILabel = UILabel()
    private var phoneVisibilityTable: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var phoneVisibilityData = [
        [("Everyone"), ("Only me"), ("Specified")],
        [("Never show"), ("Always show")]
    ]
    let interactor: PhoneVisibilityScreenBusinessLogic
    
    // MARK: - initialization
    init(interactor: PhoneVisibilityScreenBusinessLogic) {
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
        view.backgroundColor = Colors.background
        interactor.loadUserRestrictions()
        configureBackArrow()
        configurePhoneVisibilityTable()
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
    
    // MARK: - Back Arrow Configuration
    private func configureBackArrow() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.arrowName), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.text
    }
    
    // MARK: - Phone Visibility Table Configuration
    private func configurePhoneVisibilityTable() {
        view.addSubview(phoneVisibilityTable)
        phoneVisibilityTable.delegate = self
        phoneVisibilityTable.dataSource = self
        phoneVisibilityTable.separatorStyle = .singleLine
        phoneVisibilityTable.separatorInset = .zero
        phoneVisibilityTable.pinHorizontal(view)
        phoneVisibilityTable.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.tableTop)
        phoneVisibilityTable.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, Constants.tableBottom)
        phoneVisibilityTable.register(VisibilityCell.self, forCellReuseIdentifier: VisibilityCell.cellIdentifier)
        phoneVisibilityTable.register(ExceptionsCell.self, forCellReuseIdentifier: ExceptionsCell.cellIdentifier)
        phoneVisibilityTable.backgroundColor = view.backgroundColor
    }
    
    // MARK: - Exceptions Section Updating
    // Edits the second section depending on what is selected in the first.
    private func updateExceptionsSection() {
        switch selectedIndex?.row {
        case 0:
            phoneVisibilityData[1] = [(Constants.neverText)]
        case 1:
            phoneVisibilityData[1] = [(Constants.neverText), (Constants.alwaysText)]
        case 2:
            phoneVisibilityData[1] = [(Constants.alwaysText)]
        default:
            break
        }
    }
    //TODO: - probably here i will take id of special users(if current user tapped "specified" option)
    private func transferRestriction() -> String{
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
        let phoneRestriction = transferRestriction()
        interactor.backToConfidentialityScreen(phoneRestriction)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension PhoneVisibilityScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Mark Current Option
    // Called during screen configuration to check the box depending on the data in the user defaults storage
    public func markCurrentOption(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        var rowIndex: Int
        switch userRestrictions.phone.openTo {
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
        return phoneVisibilityData.count
    }
    
    // MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phoneVisibilityData[section].count
    }
    
    // MARK: - Configuration and returning the cell for the specified index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VisibilityCell.cellIdentifier, for: indexPath) as? VisibilityCell else {
                return UITableViewCell()
            }
            let item = phoneVisibilityData[indexPath.section][indexPath.row]
            let isSelected = (indexPath == selectedIndex)
            cell.configure(title: item, isSelected: isSelected)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExceptionsCell.cellIdentifier, for: indexPath) as? ExceptionsCell else {
                return UITableViewCell()
            }
            let item = phoneVisibilityData[indexPath.section][indexPath.row]
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
            label.text = Constants.whoCanSeeLabelText
        case 1:
            label.text = Constants.exceptionsLabelText
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
