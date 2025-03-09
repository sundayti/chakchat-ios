//
//  LanguageCell.swift
//  chakchat
//
//  Created by лизо4ка курунок on 15.02.2025.
//

import UIKit

// MARK: - LanguageCell
final class LanguageCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIdentifier = "LanguageCell"
    
    private enum Constants {
        static let currentOptionTrailing: CGFloat = 10
        static let languageLeading: CGFloat = 10
    }

    // MARK: - Properties
    private let languageLocalizedLabel = UILabel()
    private let languageLabel = UILabel()
    private let checkmarkImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(title: [String], isSelected: Bool, isLoading: Bool) {
        languageLocalizedLabel.text = title[0]
        languageLabel.text = title[1]
        checkmarkImageView.isHidden = isLoading || !isSelected
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    private func configureCell() {
        configureCheckmark()
        configureLocalizedLanguageLabel()
        configureLanguageLabel()
        configureActivityIndicator()
    }
    
    private func configureCheckmark() {
        contentView.addSubview(checkmarkImageView)
        checkmarkImageView.image = UIImage(systemName: "checkmark")
        checkmarkImageView.tintColor = .orange
        checkmarkImageView.isHidden = true
        checkmarkImageView.pinCenterY(contentView)
        checkmarkImageView.pinRight(contentView, Constants.currentOptionTrailing)
    }
    
    private func configureActivityIndicator() {
        contentView.addSubview(activityIndicator)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = false
        activityIndicator.color = .orange
        activityIndicator.pinCenterY(contentView)
        activityIndicator.pinRight(contentView, Constants.currentOptionTrailing)
    }
    
    private func configureLocalizedLanguageLabel() {
        contentView.addSubview(languageLocalizedLabel)
        languageLocalizedLabel.font = Fonts.systemR16
        languageLocalizedLabel.textColor = Colors.text
        languageLocalizedLabel.pinTop(contentView, 5)
        languageLocalizedLabel.pinLeft(contentView, Constants.languageLeading)
    }
    
    private func configureLanguageLabel() {
        contentView.addSubview(languageLabel)
        languageLabel.font = Fonts.systemR12
        languageLabel.textColor = Colors.text
        languageLabel.pinTop(languageLocalizedLabel.bottomAnchor, 3)
        languageLabel.pinLeft(contentView, Constants.languageLeading)
        languageLabel.pinBottom(contentView, 5)
    }
}
