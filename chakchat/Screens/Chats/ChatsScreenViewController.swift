//
//  ChatsScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit
import Combine

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
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    init(interactor: ChatsScreenBusinessLogic) {
        self.interactor = interactor
        searchController = UISearchController(searchResultsController: UsersSearchViewController(interactor: interactor))
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
        guard let searchVC = searchController.searchResultsController as? UsersSearchViewController else { return }
        if let searchText = searchController.searchBar.text {
            searchVC.searchTextPublisher.send(searchText)
        }
    }
}

final class UsersSearchViewController: UIViewController {
    private let usersTableView: UITableView = UITableView()
    private var users: [ProfileSettingsModels.ProfileUserData] = []
    private var isLoading = false
    private var currentPage = 1
    private let limit = 10
    private var lastQuery: String?
    let searchTextPublisher = PassthroughSubject<String, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    let interactor: ChatsScreenBusinessLogic
    
    init(interactor: ChatsScreenBusinessLogic) {
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
    
    private func configureUI() {
        view.backgroundColor = .white
        configureSearchTableView()
        bindSearch()
    }
    
    private func configureSearchTableView() {
        view.addSubview(usersTableView)
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.pinTop(view.safeAreaLayoutGuide.topAnchor, 0)
        usersTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 0)
        usersTableView.pinLeft(view.safeAreaLayoutGuide.leadingAnchor, 0)
        usersTableView.pinRight(view.safeAreaLayoutGuide.trailingAnchor, 0)
        usersTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func bindSearch() {
        searchTextPublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .print("Datastream")
            .sink { [weak self] query in
                self?.startNewSearch(query)
            }.store(in: &cancellable)
    }
    
    private func startNewSearch(_ query: String) {
        guard !query.isEmpty else {
            users = []
            usersTableView.reloadData()
            return
        }
        currentPage = 1
        lastQuery = query
        users = []
        fetchUsers(query, currentPage)
    }

    private func fetchUsers(_ query: String, _ page: Int) {
        /// эти страшные манипуляции для того, чтобы определить, пользователь хочет провести поиск
        /// по name или username.
        /// Мы проверяем имеет ли запрос префикс "@", если имеет: то поле name будет равно nil, т.к
        /// поиск будет проводиться по username
        /// Если поле  isUsername == nil, то поле username становится  nil, в противном случае - отбрасываем
        /// префикс "@" и кладем в запрос
        guard !isLoading else { return }
        isLoading = true
        let isUsername = query.hasPrefix("@")
        let name = isUsername ? nil : query
        let username = isUsername ? String(query.dropFirst()) : nil
        
        interactor.fetchUsers(name, username, page, limit) { [weak self] result in
            guard let self = self else { return }
            isLoading = false
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.users = response.users.filter { user in
                        user.name.lowercased().contains(query.lowercased()) ||
                        user.username.lowercased().contains(query.lowercased())
                    }
                    self.usersTableView.reloadData()
                }
            case .failure(let failure):
                interactor.handleError(failure)
            }
        }
    }
}

extension UsersSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = "\(user.name) @\(user.username)"
        return cell
    }
    // пагинация
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if offsetY > contentHeight - frameHeight * 2 {
            loadMoreUsers()
        }
    }
    
    private func loadMoreUsers() {
        guard let query = lastQuery else { return }
        currentPage += 1
        fetchUsers(query, currentPage)
    }
}

