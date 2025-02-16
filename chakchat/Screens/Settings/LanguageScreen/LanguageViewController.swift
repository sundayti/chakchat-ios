//
//  LanguageViewController.swift
//  chakchat
//
//  Created by лизо4ка курунок on 15.02.2025.
//

import UIKit

final class LanguageViewController: UIViewController {
    
    private enum Constants {
        static let headerText: String = NSLocalizedString("Language", comment: "")
    }
    
    private let interactor: LanguageBusinessLogic
    
    private var selectedIndex: IndexPath?
    private var titleLabel: UILabel = UILabel()
    private var languages = [
        NSLocalizedString("english", comment: ""),
        NSLocalizedString("russian", comment: ""),
        NSLocalizedString("italian", comment: "")
    ]
    private var isLoadingIndex: IndexPath? = nil
    private var languageTableView: UITableView = UITableView(frame: .zero, style: .insetGrouped)
    
    init(interactor: LanguageBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: .languageDidChange, object: nil)
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Colors.background
        configureBackButton()
        configureTitleLabel()
        navigationItem.titleView = titleLabel
        configureLanguageTable()
        markCurrentOption()
    }
    
    private func configureBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.text
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB24
        titleLabel.text = Constants.headerText
        titleLabel.textAlignment = .center
    }
    
    private func configureLanguageTable() {
        view.addSubview(languageTableView)
        languageTableView.delegate = self
        languageTableView.dataSource = self
        languageTableView.separatorStyle = .singleLine
        languageTableView.pinHorizontal(view)
        languageTableView.pinTop(view.safeAreaLayoutGuide.topAnchor, 0)
        languageTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 40)
        languageTableView.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.cellIdentifier)
        languageTableView.backgroundColor = view.backgroundColor
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func backButtonPressed() {
        interactor.backToSettingsMenu()
    }
    
    @objc
    private func languageDidChange() {
        titleLabel.text = LocalizationManager.shared.localizedString(for: "Language")
        titleLabel.sizeToFit()
        languages = [
            LocalizationManager.shared.localizedString(for: "english"),
            LocalizationManager.shared.localizedString(for: "russian"),
            LocalizationManager.shared.localizedString(for: "italian")
        ]
        languageTableView.reloadData()
    }

}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func markCurrentOption() {
        var rowIndex: Int
        switch Locale.current.languageCode {
        case "en":
            rowIndex = 0
        case "ru":
            rowIndex = 1
        case "it":
            rowIndex = 2
        default:
            rowIndex = 0
            break
        }
        selectedIndex = IndexPath(row: rowIndex, section: 0)
    }
    
    // MARK: - numberOfSections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    // MARK: - Configuration and returning the cell for the specified index
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.cellIdentifier, for: indexPath) as? LanguageCell else {
            return UITableViewCell()
        }

        let item = languages[indexPath.row]
        let isSelected = (indexPath == selectedIndex)
        let isLoading = (indexPath == isLoadingIndex)

        cell.configure(title: item, isSelected: isSelected, isLoading: isLoading)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if selectedIndex != indexPath {
            isLoadingIndex = indexPath
            tableView.reloadRows(at: [indexPath], with: .none)

            let selectedLanguage: String
            switch indexPath.row {
            case 0: selectedLanguage = "en"
            case 1: selectedLanguage = "ru"
            case 2: selectedLanguage = "it"
            default: selectedLanguage = "en"
            }

            interactor.updateLanguage(to: selectedLanguage) {
                DispatchQueue.main.async {
                    self.selectedIndex = indexPath
                    self.isLoadingIndex = nil
                    tableView.reloadData()
                }
            }
        }
    }
}

