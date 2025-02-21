//
//  UsersSearchViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.02.2025.
//

import UIKit

final class UsersSearchViewController: UIViewController {
    private let usersTableView: UITableView = UITableView()
    private var users: [ProfileSettingsModels.ProfileUserData] = []
    private var currentPage = 1
    let interactor: UsersSearchBusinessLogic
    
    init(interactor: UsersSearchBusinessLogic) {
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
    
    
    public func showUsers(_ users: ProfileSettingsModels.Users) {
        
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureSearchTableView()
    }
    
    private func configureSearchTableView() {
        view.addSubview(usersTableView)
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.pinTop(view.safeAreaLayoutGuide.topAnchor, 0)
        usersTableView.pinBottom(view.safeAreaLayoutGuide.bottomAnchor, 0)
        usersTableView.pinLeft(view.safeAreaLayoutGuide.leadingAnchor, 0)
        usersTableView.pinRight(view.safeAreaLayoutGuide.trailingAnchor, 0)
    }
    
    private func searchUsers(_ name: String?, _ username: String?) {
        currentPage = 1
        users.removeAll()
        usersTableView.reloadData()
        interactor.fetchUsers(name, username, currentPage, 10)
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
}
