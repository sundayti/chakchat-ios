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
        static let searchPlaceholder: String = LocalizationManager.shared.localizedString(for: "search")
    }
    
    // MARK: - Properties
    private let interactor: NewGroupBusinessLogic
    private let titleLabel: UILabel = UILabel()
    
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
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Colors.backgroundSettings
        configureBackButton()
        configureTitleLabel()
        navigationItem.titleView = titleLabel
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
        titleLabel.text = LocalizationManager.shared.localizedString(for: "group")
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        interactor.backToNewMessageScreen()
    }
}
