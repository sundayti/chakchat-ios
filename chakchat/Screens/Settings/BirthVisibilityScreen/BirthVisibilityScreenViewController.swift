//
//  BirthVisibilityScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit
final class BirthVisibilityScreenViewController: UIViewController {
    
    private var selectedIndex: IndexPath?
    private var birthVisibilityTable: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    private var birthVisibilitySection = [("All"), ("Only contacts"), ("Nobody")]
    let interactor: BirthVisibilityScreenBusinessLogic
    
    init(interactor: BirthVisibilityScreenBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .black
        interactor.loadUserData()
        configurePhoneVisibilityTable()
    }
    
    private func configurePhoneVisibilityTable() {
        view.addSubview(birthVisibilityTable)
        birthVisibilityTable.delegate = self
        birthVisibilityTable.dataSource = self
        birthVisibilityTable.separatorStyle = .singleLine
        birthVisibilityTable.pinHorizontal(view)
        birthVisibilityTable.pinTop(view.safeAreaLayoutGuide.topAnchor, 20)
        birthVisibilityTable.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 20)
        birthVisibilityTable.register(VisibilityCell.self, forCellReuseIdentifier: VisibilityCell.cellIdentifier)
        birthVisibilityTable.backgroundColor = view.backgroundColor
    }
    
    @objc
    private func backButtonPressed() {
        interactor.backToConfidentialityScreen()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BirthVisibilityScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func markCurrentOption(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        var rowIndex: Int
        switch birthVisibility.birthStatus {
        case .all:
            rowIndex = 0
        case .onlyContacts:
            rowIndex = 1
        case .nobody:
            rowIndex = 2
        }
        selectedIndex = IndexPath(row: rowIndex, section: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: VisibilityCell.cellIdentifier, for: indexPath) as? VisibilityCell else {
            return UITableViewCell()
        }
        let item = birthVisibilitySection[indexPath.row]
        let isSelected = (indexPath == selectedIndex)
        cell.configure(title: item, isSelected: isSelected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 20, y: 10, width: headerView.frame.width-10, height: headerView.frame.height-10)
        switch section {
        case 0:
            label.text = "Who can see my birth data"
        default:
            label.text = nil
        }
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedIndex != indexPath {
            selectedIndex = indexPath
        }
        tableView.reloadData()
        switch indexPath.row {
        case 0:
            let newBirthVisibility = BirthVisibilityScreenModels.BirthVisibility(birthStatus: .all)
            interactor.saveNewData(newBirthVisibility)
        case 1:
            let newBirthVisibility = BirthVisibilityScreenModels.BirthVisibility(birthStatus: .all)
            interactor.saveNewData(newBirthVisibility)
        case 2:
            let newBirthVisibility = BirthVisibilityScreenModels.BirthVisibility(birthStatus: .all)
            interactor.saveNewData(newBirthVisibility)
        default:
            break
        }
    }
}
