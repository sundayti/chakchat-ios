//
//  SettingsMenuCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit
final class SettingsMenuCell: UITableViewCell {
    
    static let cellIdentifier = "SettingsMenuCell"
    
    let settingImageView: UIImageView = UIImageView()
    let settingTitle: UILabel = UILabel()
    let chevronButton: UIButton = UIButton(type: .system)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureImage()
        configureSettingNameLabel()
        configureChevronButton()
    }
        
    private func configureImage() {
        contentView.addSubview(settingImageView)
        settingImageView.contentMode = .scaleAspectFill
        settingImageView.tintColor = UIColor(hex: "FF9D00")
        settingImageView.pinLeft(contentView.leadingAnchor, 12)
        settingImageView.pinCenterY(contentView.centerYAnchor)
        settingImageView.setHeight(24)
        settingImageView.setWidth(24)
    }
    
    private func configureSettingNameLabel() {
        contentView.addSubview(settingTitle)
        settingTitle.font = UIFont.systemFont(ofSize: 16)
        settingTitle.pinCenterY(contentView.centerYAnchor)
        settingTitle.pinLeft(settingImageView.trailingAnchor, 12)
    }
    
    private func configureChevronButton() {
        contentView.addSubview(chevronButton)
        chevronButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        chevronButton.tintColor = UIColor(hex: "FF9D00")
        chevronButton.contentVerticalAlignment = .fill
        chevronButton.contentHorizontalAlignment = .fill
        chevronButton.pinRight(contentView.trailingAnchor, 16)
        chevronButton.pinCenterY(contentView.centerYAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, with image: UIImage) {
        settingTitle.text = title
        settingImageView.image = image
    }
}
