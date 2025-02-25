//
//  NewMessageViewController.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import UIKit

// MARK: - NewMessageViewController
final class NewMessageViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let arrowLabel: String = "arrow.left"
        static let searchPlaceholder: String = LocalizationManager.shared.localizedString(for: "search")
    }
    
    // MARK: - Properties
    private let interactor: NewMessageBusinessLogic
    private let titleLabel: UILabel = UILabel()
    private let searchController: UISearchController
    private let newGroupButton: UINewGroupButton = UINewGroupButton()
    private let tableView: UITableView = UITableView()
    private var newGroupButtonTopConstraint: NSLayoutConstraint!
    private var shouldAnimateNewGroupButton = false
    
    // MARK: - Initialization
    init(interactor: NewMessageBusinessLogic) {
        self.interactor = interactor
        searchController = UISearchController(searchResultsController: UIUsersSearchViewController(interactor: interactor))
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
        view.backgroundColor = Colors.backgroundSettings
        configureBackButton()
        configureTitleLabel()
        navigationItem.titleView = titleLabel
        configureSearchController()
        configureNewGroupButton()
    }
    
    // MARK: - Back Button Configuration
    private func configureBackButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: Constants.arrowLabel), style: .plain, target: self, action: #selector(backButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = Colors.text
        // Adding returning to previous screen with swipe.
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(backButtonPressed))
        swipeGesture.direction = .right
        view.addGestureRecognizer(swipeGesture)
    }
    
    // MARK: - Title Label Configure
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB24
        titleLabel.text = LocalizationManager.shared.localizedString(for: "new_message")
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Search Controller Configuration
    private func configureSearchController() {
        searchController.delegate = self
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = Constants.searchPlaceholder
        searchController.searchBar.autocapitalizationType = .none
        searchController.searchBar.autocorrectionType = .no
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.setValue(LocalizationManager.shared.localizedString(for: "cancel"), forKey: "cancelButtonText")
        definesPresentationContext = true
    }
    
    // MARK: - New Group Configuration
    private func configureNewGroupButton() {
        view.addSubview(newGroupButton)
        newGroupButton.pinLeft(view, 10)
        newGroupButton.pinRight(view, 10)
        newGroupButtonTopConstraint = newGroupButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10)
        newGroupButtonTopConstraint.isActive = true
        newGroupButton.setHeight(50)
        newGroupButton.addTarget(self, action: #selector(newGroupButtonPressed), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if shouldAnimateNewGroupButton {
            if searchController.isActive {
                animateNewGroupButton(constant: 0)
            } else {
                animateNewGroupButton(constant: -10)
            }
        }
        shouldAnimateNewGroupButton = false
    }
    
    private func animateNewGroupButton(constant: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.newGroupButtonTopConstraint.constant = constant
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Table Configuration
    private func configureTableView() {
        
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        interactor.backToChatsScreen()
    }
    
    @objc
    private func newGroupButtonPressed() {
        // go to new group screen
    }
}

extension NewMessageViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchVC = searchController.searchResultsController as? UIUsersSearchViewController else { return }
        if let searchText = searchController.searchBar.text {
            searchVC.searchTextPublisher.send(searchText)
        }
    }
}

extension NewMessageViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        shouldAnimateNewGroupButton = true
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        shouldAnimateNewGroupButton = true
    }
}


