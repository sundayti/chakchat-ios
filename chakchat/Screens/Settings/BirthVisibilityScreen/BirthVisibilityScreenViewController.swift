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
    private var birthVisibilityData = [
        [("All"), ("Custom"), ("Nobody")],
        [("Never show"), ("Always show")]
    ]
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
        birthVisibilityTable.register(ExceptionsCell.self, forCellReuseIdentifier: ExceptionsCell.cellIdentifier)
        birthVisibilityTable.backgroundColor = view.backgroundColor
    }
    
    // она редактирует вторую секцию в зависимости от того что в первой выбрано
    private func updateExceptionsSection() {
        switch selectedIndex?.row {
        case 0:
            birthVisibilityData[1] = [("Never show")]
        case 1:
            birthVisibilityData[1] = [("Never show"), ("Always show")]
        case 2:
            birthVisibilityData[1] = [("Always show")]
        default:
            break
        }
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
    
    // это вызывается при конфигурации экрана чтобы галочку поставить в зависимости от данных в user defaults хранилище
    public func markCurrentOption(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        var rowIndex: Int
        switch birthVisibility.birthStatus {
        case .all:
            rowIndex = 0
        case .custom:
            rowIndex = 1
        case .nobody:
            rowIndex = 2
        }
        selectedIndex = IndexPath(row: rowIndex, section: 0)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return birthVisibilityData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthVisibilityData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VisibilityCell.cellIdentifier, for: indexPath) as? VisibilityCell else {
                return UITableViewCell()
            }
            let item = birthVisibilityData[indexPath.section][indexPath.row]
            let isSelected = (indexPath == selectedIndex)
            cell.configure(title: item, isSelected: isSelected)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExceptionsCell.cellIdentifier, for: indexPath) as? ExceptionsCell else {
                return UITableViewCell()
            }
            let item = birthVisibilityData[indexPath.section][indexPath.row]
            cell.configure(title: item)
            return cell
        }
    }
    // Тут мы настраиваем заголовок к каждой секции
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel()
        // вот эта штучка ответственна за то, где именно будет располагаться заголовок относительно секции
        label.frame = CGRect.init(x: 20, y: 10, width: headerView.frame.width-10, height: headerView.frame.height-10)
        switch section {
        case 0:
            label.text = "Who can see my birth data"
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
    // отвечает за расстояние между хедерами в разных секциях
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
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
                let newBirthVisibility = BirthVisibilityScreenModels.BirthVisibility(birthStatus: .all)
                interactor.saveNewData(newBirthVisibility)
            case 1:
                let newBirthVisibility = BirthVisibilityScreenModels.BirthVisibility(birthStatus: .custom)
                interactor.saveNewData(newBirthVisibility)
            case 2:
                let newBirthVisibility = BirthVisibilityScreenModels.BirthVisibility(birthStatus: .nobody)
                interactor.saveNewData(newBirthVisibility)
            default:
                break
            }
        } else {
            // логика второй секции пока не придумана
        }
    }
}
