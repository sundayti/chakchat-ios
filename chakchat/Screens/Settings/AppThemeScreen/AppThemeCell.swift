//
//  AppThemeCell.swift
//  chakchat
//
//  Created by лизо4ка курунок on 22.02.2025.
//

import UIKit

// MARK: - AppThemeCell
final class AppThemeCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIdentifier = "AppThemeCell"
    
    private enum Constants {
        static let currentOptionTrailing: CGFloat = 10
        static let themeLeading: CGFloat = 10
    }

    // MARK: - Properties
    private let themeLabel = UILabel()
    private let checkmarkImageView = UIImageView()

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, isSelected: Bool) {
        themeLabel.text = title
        checkmarkImageView.isHidden = !isSelected
    }
    
    // MARK: - Cell Configuration
    private func configureCell() {
        configureCheckmark()
        configureThemeLabel()
    }
    
    // MARK: - Checkmark Configuartion
    private func configureCheckmark() {
        contentView.addSubview(checkmarkImageView)
        checkmarkImageView.image = UIImage(systemName: "checkmark")
        checkmarkImageView.tintColor = .orange
        checkmarkImageView.isHidden = true
        checkmarkImageView.pinCenterY(contentView)
        checkmarkImageView.pinRight(contentView, Constants.currentOptionTrailing)
    }
    
    // MARK: - Language Localized Label Configuartion
    private func configureThemeLabel() {
        contentView.addSubview(themeLabel)
        themeLabel.font = Fonts.systemR18
        themeLabel.textColor = Colors.text
        themeLabel.pinCenterY(contentView)
        themeLabel.pinLeft(contentView, Constants.themeLeading)
    }
}

