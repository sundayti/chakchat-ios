//
//  NewGroupViewController.swift
//  chakchat
//
//  Created by лизо4ка курунок on 25.02.2025.
//

import UIKit

// MARK: - NewGroupViewController
final class NewGroupViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let arrowLabel: String = "arrow.left"
        static let checkmarkLabel: String = "checkmark"
        static let emptyButtonStartTop: CGFloat = -10
        static let emptyButtonEndTop: CGFloat = 0
        static let tableTop: CGFloat = 10
        static let tableBottom: CGFloat = 0
        static let tableHorizontal: CGFloat = 0
    }
    
    // MARK: - Properties
    private let interactor: NewGroupBusinessLogic
    private let titleLabel: UINewGroupTitleLabel = UINewGroupTitleLabel()
    private var searchController: UISearchController = UISearchController()
    private var users: [ProfileSettingsModels.ProfileUserData] = []
    private var emptyButtonTopConstraint: NSLayoutConstraint!
    // Clear button. It needed cause there was a problem with pinning table top.
    private let emptyButton: UIButton = UIButton()
    private let tableView: UITableView = UITableView()
    private var shouldAnimateEmptyButton = false
    private let usersTableView: UITableView = UITableView()
    
    // MARK: - Initialization
    init(interactor: NewGroupBusinessLogic) {
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if shouldAnimateEmptyButton {
            if searchController.isActive {
                animateEmptyButton(constant: Constants.emptyButtonEndTop)
            } else {
                animateEmptyButton(constant: Constants.emptyButtonStartTop)
            }
        }
        shouldAnimateEmptyButton = false
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Colors.background
        configureBackButton()
        configureCreateButton()
        configureTitleLabel()
        configureSearchController()
        configureEmptyButton()
        configureTableView()
    }
    
    // MARK: - Back Button Configuration
    private func configureBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.arrowLabel), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.orange
        // Adding returning to previous screen with swipe.
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(backButtonPressed))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    // MARK: - Create Button Configuration
    private func configureCreateButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.checkmarkLabel), style: .plain, target: self, action: #selector(createButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = Colors.orange
    }
    
    // MARK: - Title Label Configure
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        navigationItem.titleView = titleLabel
    }
    
    // MARK: - Search Controller Configuration
    private func configureSearchController() {
        let searchResultsController = UIUsersSearchViewController(interactor: interactor)
        searchResultsController.onUserSelected = { [weak self] user in
            self?.handleSelectedUser(user)
        }
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = LocalizationManager.shared.localizedString(for: "who_would_you_add")
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.setValue(LocalizationManager.shared.localizedString(for: "cancel"), forKey: "cancelButtonText")
        definesPresentationContext = true
    }
    
    // MARK: - New Group Configuration
    private func configureEmptyButton() {
        view.addSubview(emptyButton)
        emptyButton.pinLeft(view, 10)
        emptyButton.pinRight(view, 10)
        emptyButtonTopConstraint = emptyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10)
        emptyButtonTopConstraint.isActive = true
        emptyButton.setHeight(0)
    }
    
    // MARK: - Table Configuration
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.pinTop(emptyButton.bottomAnchor, Constants.tableTop)
        tableView.pinBottom(view, Constants.tableBottom)
        tableView.pinLeft(view, Constants.tableHorizontal)
        tableView.pinRight(view, Constants.tableHorizontal)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Empty Button Animation.
    // we pin empty button to end of navigation bar and animate it when user tap to searchBar.
    // tableView is pinned to emptyButton so it is animated too.
    private func animateEmptyButton(constant: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.emptyButtonTopConstraint.constant = constant
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Handling user selected.
    private func handleSelectedUser(_ user: ProfileSettingsModels.ProfileUserData) {
        users.append(user)
        titleLabel.updateCounter(users.count)
        tableView.reloadData()
        searchController.isActive = false
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        interactor.backToNewMessageScreen()
    }
    
    @objc
    private func createButtonPressed() {
        // Creating group
    }
}

// MARK: - UISearchResultsUpdating
extension NewGroupViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchVC = searchController.searchResultsController as? UIUsersSearchViewController else { return }
        if let searchText = searchController.searchBar.text {
            searchVC.searchTextPublisher.send(searchText)
        }
    }
}

// MARK: - UISearchControllerDelegate
extension NewGroupViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        shouldAnimateEmptyButton = true
    }

    func willDismissSearchController(_ searchController: UISearchController) {
        shouldAnimateEmptyButton = true
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
// TODO: make pretty cells here and everywhere where searchBar is.
extension NewGroupViewController: UITableViewDelegate, UITableViewDataSource {
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
