//
//  ChatsScreenViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit
final class ChatsScreenViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var settingButton: UIButton = UIButton(type: .system)
    private lazy var newChatButton: UIButton = UIButton(type: .system)
    var interactor: ChatsScreenBusinessLogic
    
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
        configureTitleLabel()
        navigationItem.title = titleLabel.text
        configureSettingsButton()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: settingButton)
        configureNewChatButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: newChatButton)
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.text = "Chats"
    }
    
    private func configureSettingsButton() {
        view.addSubview(settingButton)
        settingButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingButton.contentHorizontalAlignment = .fill
        settingButton.contentVerticalAlignment = .fill
        settingButton.setHeight(40)
        settingButton.setWidth(40)
        settingButton.addTarget(self, action: #selector(settingButtonPressed), for: .touchUpInside)
    }
    
    private func configureNewChatButton() {
        view.addSubview(newChatButton)
        newChatButton.setImage(UIImage(systemName: "plus"), for: .normal)
        newChatButton.contentHorizontalAlignment = .fill
        newChatButton.contentVerticalAlignment = .fill
        newChatButton.setHeight(40)
        newChatButton.setWidth(40)
    }
    
    @objc
    private func settingButtonPressed() {
        navigationController?.pushViewController(SettingsScreenAssembly.build(), animated: true)
    }
}
