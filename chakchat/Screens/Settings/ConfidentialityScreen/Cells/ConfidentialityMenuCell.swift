//
//  ConfidentialityMenuCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import UIKit
final class ConfidentialityMenuCell: UITableViewCell {
    
    static let cellIdentifier = "ConfidentialityCell"
    
    private let settingIcon: UIImageView = UIImageView()
    private let settingLabel: UILabel = UILabel()
    private let settingStatus: UILabel = UILabel()
    private var hasIcon: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(title: String, icon: UIImage?, status: String) {
        settingLabel.text = title
        settingStatus.text = status
        if icon != nil {
            settingIcon.image = icon
        } else {
            settingLabel.pinLeft(contentView.leadingAnchor, 10)
        }
    }
    
    private func configureCell() {
        configureSettingIcon()
        configureSettingLabel()
        configureSettingStatus()
    }
    
    private func configureSettingIcon() {
        contentView.addSubview(settingIcon)
        settingIcon.contentMode = .scaleAspectFill
        settingIcon.pinLeft(contentView.leadingAnchor, 10)
        settingIcon.pinCenterY(contentView)
        settingIcon.setWidth(24)
        settingIcon.setHeight(24)
    }
    
    private func configureSettingLabel() {
        contentView.addSubview(settingLabel)
        settingLabel.tintColor = .black
        settingLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        settingLabel.pinCenterY(contentView)
        settingLabel.pinLeft(settingIcon.trailingAnchor, 10)
    }
    
    private func configureSettingStatus() {
        contentView.addSubview(settingStatus)
        settingStatus.textColor = .gray
        settingStatus.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        settingStatus.pinCenterY(contentView)
        settingStatus.pinRight(contentView.trailingAnchor, 10)
    }
}
