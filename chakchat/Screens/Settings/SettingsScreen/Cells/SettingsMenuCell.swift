//
//  SettingsMenuCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit

// MARK: - SettingsMenuCell
final class SettingsMenuCell: UITableViewCell {
    
    // MARK: - Constants
    private enum Constants {
        static let settingsImageLeading: CGFloat = 12
        static let settingsImageSize: CGFloat = 24
        static let settingsLabelLeading: CGFloat = 12
        
        static let chevronPointSize: CGFloat = 15
        static let chevronName: String = "chevron.right"
        static let chevronTrailing: CGFloat = 16
    }
    
    // MARK: - Properties
    static let cellIdentifier = "SettingsMenuCell"
    
    let settingImageView: UIImageView = UIImageView()
    let settingTitle: UILabel = UILabel()
    let chevronButton: UIButton = UIButton(type: .system)
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImage()
        configureSettingNameLabel()
        configureChevronButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with title: String, with image: UIImage?) {
        settingTitle.text = title
        settingImageView.image = image
    }
        
    private func configureImage() {
        contentView.addSubview(settingImageView)
        settingImageView.contentMode = .scaleAspectFill
        settingImageView.tintColor = Colors.lightOrange
        settingImageView.pinLeft(contentView.leadingAnchor, Constants.settingsImageLeading)
        settingImageView.pinCenterY(contentView.centerYAnchor)
        settingImageView.setHeight(Constants.settingsImageSize)
        settingImageView.setWidth(Constants.settingsImageSize)
    }
    
    private func configureSettingNameLabel() {
        contentView.addSubview(settingTitle)
        settingTitle.font = Fonts.systemR16
        settingTitle.pinCenterY(contentView.centerYAnchor)
        settingTitle.pinLeft(settingImageView.trailingAnchor, Constants.settingsLabelLeading)
    }
    
    private func configureChevronButton() {
        contentView.addSubview(chevronButton)
        let config = UIImage.SymbolConfiguration(pointSize: Constants.chevronPointSize, weight: .regular, scale: .default)
        let gearImage = UIImage(systemName: Constants.chevronName, withConfiguration: config)
        chevronButton.tintColor = Colors.lightOrange
        chevronButton.setImage(gearImage, for: .normal)
        chevronButton.contentVerticalAlignment = .fill
        chevronButton.contentHorizontalAlignment = .fill
        chevronButton.pinRight(contentView.trailingAnchor, Constants.chevronTrailing)
        chevronButton.pinCenterY(contentView.centerYAnchor)
    }
}
