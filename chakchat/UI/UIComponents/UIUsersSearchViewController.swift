//
//  UIUsersSearchViewController.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import UIKit
import Combine

// MARK: - UIUsersSearchViewController
final class UIUsersSearchViewController: UIViewController {
    
    // MARK: - Properties
    private let usersTableView: UITableView = UITableView()
    private var users: [ProfileSettingsModels.ProfileUserData] = []
    private var isLoading = false
    private var currentPage = 1
    private let limit = 10
    private var lastQuery: String?
    let searchTextPublisher = PassthroughSubject<String, Never>()
    private var cancellable = Set<AnyCancellable>()
    var onUserSelected: ((ProfileSettingsModels.ProfileUserData) -> Void)?
    
    let interactor: SearchInteractor
    
    // MARK: - Initialization
    init(interactor: SearchInteractor) {
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
        usersTableView.separatorInset = .zero
        usersTableView.register(UISearchControllerCell.self, forCellReuseIdentifier: "SearchControllerCell")
    }
    
    // MARK: - Searching methods
    private func bindSearch() {
        searchTextPublisher
            //.debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .print("Datastream/search")
            .sink { [weak self] query in
                self?.startNewSearch(query)
            }.store(in: &cancellable)
    }
    
    private func startNewSearch(_ query: String) {
        users = []
        usersTableView.reloadData()
        
        guard !query.isEmpty else {
            return
        }
        
        currentPage = 1
        lastQuery = query
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
                self.users = response.users.filter { user in
                    user.name.lowercased().contains(query.lowercased()) ||
                    user.username.lowercased().contains(query.lowercased())
                }
                DispatchQueue.main.async {
                    self.usersTableView.reloadData()
                }
            case .failure(let failure):
                interactor.handleError(failure)
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension UIUsersSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchControllerCell", for: indexPath) as? UISearchControllerCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.configure(user.photo, user.name, deletable: false)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = users[indexPath.row]
        onUserSelected?(selectedUser)
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
