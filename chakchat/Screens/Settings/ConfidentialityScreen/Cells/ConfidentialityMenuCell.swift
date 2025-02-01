//
//  ConfidentialityMenuCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import UIKit

// MARK: - ConfidentialityMenuCell
final class ConfidentialityMenuCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIdentifier = "ConfidentialityCell"
    
    // MARK: - Properties
    private let settingLabel: UILabel = UILabel()
    private let settingStatus: UILabel = UILabel()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Settings Configuration
    public func configureSettings(title: String, status: String) {
        settingLabel.text = title
        settingStatus.text = status
    }
    
    // MARK: - Cell Configuration
    private func configureCell() {
        configureSettingLabel()
        configureSettingStatus()
    }
    
    // MARK: - Setting Label Configuration
    private func configureSettingLabel() {
        contentView.addSubview(settingLabel)
        settingLabel.tintColor = .black
        settingLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        settingLabel.pinCenterY(contentView)
        settingLabel.pinLeft(contentView.leadingAnchor, 10)
    }
    
    // MARK: - Setting Status Configuration
    private func configureSettingStatus() {
        contentView.addSubview(settingStatus)
        settingStatus.textColor = .gray
        settingStatus.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        settingStatus.pinCenterY(contentView)
        settingStatus.pinRight(contentView.trailingAnchor, 10)
    }
}
