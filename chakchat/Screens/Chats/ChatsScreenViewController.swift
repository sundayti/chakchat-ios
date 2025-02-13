//
//  ChatsScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit

// MARK: - ChatsScreenViewController
final class ChatsScreenViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let cancelAnimationDuration: TimeInterval = 0.1
        static let animationTransformX: CGFloat = -10
        static let animationTransformY: CGFloat = 0
        static let cancelButtonTitle: String = "Cancel"
        static let cancelKey: String = "cancelButton"
        
        static let searchPlaceholder: String = "Search"
        static let searchTrailing: CGFloat = 16
        static let saerchLeading: CGFloat = 16
        static let searchTop: CGFloat = 10
        
        static let headerText: String = "Chats"
        static let symbolSize: CGFloat = 30
        static let settingsName: String = "gearshape"
        static let plusName: String = "plus"
    }
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var settingButton: UIButton = UIButton(type: .system)
    private lazy var newChatButton: UIButton = UIButton(type: .system)
    private lazy var searchBar: UISearchBar = UISearchBar()
    var interactor: ChatsScreenBusinessLogic
    
    // MARK: - Lifecycle
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Colors.background
        configureTitleLabel()
        navigationItem.title = titleLabel.text
        configureSettingsButton()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingButton)
        configureNewChatButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: newChatButton)
        configurateSearchBar()
    }
    
    // MARK: - Title Label Configuration
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB24
        titleLabel.text = Constants.headerText
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
    }
    
    // MARK: - Search Bar Configuration
    private func configurateSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.placeholder = Constants.searchPlaceholder
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = .minimal

        searchBar.pinLeft(view, Constants.saerchLeading)
        searchBar.pinRight(view, Constants.searchTrailing)
        searchBar.pinTop(view.safeAreaLayoutGuide.topAnchor, Constants.searchTop)
    }
    
    // MARK: - Actions
    @objc
    private func settingButtonPressed() {
        interactor.routeToSettingsScreen()
    }
    
    @objc
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchBarDelegate
extension ChatsScreenViewController: UISearchBarDelegate {
    
    // MARK: - searchBarTextDidBeginEditing
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        if let cancelButton = searchBar.value(forKey: Constants.cancelKey) as? UIButton {
            cancelButton.setTitle(Constants.cancelButtonTitle, for: .normal)
            cancelButton.setTitleColor(Colors.orange, for: .normal)
        }
        
        UIView.animate(withDuration: Constants.cancelAnimationDuration) {
            self.searchBar.transform = CGAffineTransform(translationX: Constants.animationTransformX, y: Constants.animationTransformY)
        }
    }

    // MARK: - searchBarCancelButtonClicked
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)

        UIView.animate(withDuration: Constants.cancelAnimationDuration) {
            self.searchBar.transform = .identity
        }
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
