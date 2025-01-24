//
//  ProfileSettingsViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit
final class ProfileSettingsViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = UILabel()
    private lazy var iconImageView: UIImageView = UIImageView()
    let interactor: ProfileSettingsBusinessLogic
    
    init(interactor: ProfileSettingsBusinessLogic) {
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem?.tintColor = .orange
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .plain, target: self, action: #selector(applyButtonPressed))
        navigationItem.rightBarButtonItem?.tintColor = .orange
        configureIconImageView()
    }
    
    private func configureTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.text = "Account\nSettings"
    }
    
    private func configureIconImageView() {
        view.addSubview(iconImageView)
        iconImageView.setHeight(90)
        iconImageView.setWidth(90)
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.layer.cornerRadius = iconImageView.frame.width / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.pinCenterX(view)
        iconImageView.pinTop(titleLabel.bottomAnchor, 20)
    }
    
    @objc
    private func cancelButtonPressed() {
        interactor.backToSettingsMenu()
    }
    
    @objc
    private func applyButtonPressed() {
        interactor.saveNewData()
    }
}
