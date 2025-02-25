//
//  ChatsScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit

// MARK: - ChatsScreenViewController
final class ChatsScreenViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let cancelAnimationDuration: TimeInterval = 0.1
        static let animationTransformX: CGFloat = -10
        static let animationTransformY: CGFloat = 0
        static let cancelButtonTitle: String = LocalizationManager.shared.localizedString(for: "cancel")
        static let cancelKey: String = "cancelButton"
        
        static let searchPlaceholder: String = LocalizationManager.shared.localizedString(for: "search")
        static let searchTrailing: CGFloat = 16
        static let saerchLeading: CGFloat = 16
        static let searchTop: CGFloat = 10
        
        static let headerText: String = LocalizationManager.shared.localizedString(for: "chats")
        static let symbolSize: CGFloat = 30
        static let settingsName: String = "gearshape"
        static let plusName: String = "plus"
    }
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var settingButton: UIButton = UIButton(type: .system)
    private lazy var newChatButton: UIButton = UIButton(type: .system)
    private let searchController: UISearchController
    private let interactor: ChatsScreenBusinessLogic
    
    // MARK: - Lifecycle
    init(interactor: ChatsScreenBusinessLogic) {
        self.interactor = interactor
        searchController = UISearchController(searchResultsController: UIUsersSearchViewController(interactor: interactor))
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: .languageDidChange, object: nil)
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Colors.background
        configureTitleLabel()
        navigationItem.titleView = titleLabel
        configureSettingsButton()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingButton)
        configureNewChatButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: newChatButton)
        configureSearchController()
    }
    
    // MARK: - Title Label Configuration
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB24
        titleLabel.text = Constants.headerText
    }
    
    // MARK: - Search Controller Configuration
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = Constants.searchPlaceholder
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.searchBar.setValue(LocalizationManager.shared.localizedString(for: "cancel"), forKey: "cancelButtonText")
        definesPresentationContext = true
    }
    
    // MARK: - Settings Button Configuration
    private func configureSettingsButton() {
        view.addSubview(settingButton)
        let config = UIImage.SymbolConfiguration(pointSize: Constants.symbolSize, weight: .light, scale: .default)
        let gearImage = UIImage(systemName: Constants.settingsName, withConfiguration: config)
        settingButton.tintColor = .gray
        settingButton.setImage(gearImage, for: .normal)
        settingButton.contentHorizontalAlignment = .fill
        settingButton.contentVerticalAlignment = .fill
        settingButton.addTarget(self, action: #selector(settingButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - New Chat Button Configuration
    private func configureNewChatButton() {
        view.addSubview(newChatButton)
        let config = UIImage.SymbolConfiguration(pointSize: Constants.symbolSize, weight: .light, scale: .default)
        let gearImage = UIImage(systemName: Constants.plusName, withConfiguration: config)
        newChatButton.tintColor = .gray
        newChatButton.setImage(gearImage, for: .normal)
        newChatButton.contentHorizontalAlignment = .fill
        newChatButton.contentVerticalAlignment = .fill
        newChatButton.addTarget(self, action: #selector(plusButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    private func settingButtonPressed() {
        interactor.routeToSettingsScreen()
    }
    
    @objc
    private func plusButtonPressed() {
        interactor.routeToNewMessageScreen()
    }
    
    @objc
    private func languageDidChange() {
        titleLabel.text = LocalizationManager.shared.localizedString(for: "chats")
        titleLabel.sizeToFit()
        searchController.searchBar.placeholder = LocalizationManager.shared.localizedString(for: "search")
        searchController.searchBar.setValue(LocalizationManager.shared.localizedString(for: "cancel"), forKey: "cancelButtonText")
    }
}

extension ChatsScreenViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchVC = searchController.searchResultsController as? UIUsersSearchViewController else { return }
        if let searchText = searchController.searchBar.text {
            searchVC.searchTextPublisher.send(searchText)
        }
    }
}

