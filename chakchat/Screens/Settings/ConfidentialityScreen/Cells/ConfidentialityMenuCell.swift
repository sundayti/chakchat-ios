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
    
    private let settingLabel: UILabel = UILabel()
    private let settingStatus: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configureSettings(title: String, status: String) {
        settingLabel.text = title
        settingStatus.text = status
    }
    
    private func configureCell() {
        configureSettingLabel()
        configureSettingStatus()
    }
    
    private func configureSettingLabel() {
        contentView.addSubview(settingLabel)
        settingLabel.tintColor = .black
        settingLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        settingLabel.pinCenterY(contentView)
        settingLabel.pinLeft(contentView.leadingAnchor, 10)
    }
    
    private func configureSettingStatus() {
        contentView.addSubview(settingStatus)
        settingStatus.textColor = .gray
        settingStatus.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        settingStatus.pinCenterY(contentView)
        settingStatus.pinRight(contentView.trailingAnchor, 10)
    }
}
