//
//  UIUsersSearchViewController.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import UIKit
import Combine

final class UIUsersSearchViewController: UIViewController {
    
    private let usersTableView: UITableView = UITableView()
    private var users: [ProfileSettingsModels.ProfileUserData] = []
    private var isLoading = false
    private var currentPage = 1
    private let limit = 10
    private var lastQuery: String?
    let searchTextPublisher = PassthroughSubject<String, Never>()
    private var cancellable = Set<AnyCancellable>()
    
    let interactor: SearchInteractor
    
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

extension UIUsersSearchViewController: UITableViewDelegate, UITableViewDataSource {
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
