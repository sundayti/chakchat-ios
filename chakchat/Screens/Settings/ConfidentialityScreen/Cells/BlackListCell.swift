//
//  BlackListCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit

// MARK: - BlackListCell
final class BlackListCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIdentifier = "BlackListCell"
    
    private enum Constants {
        static let iconLeading: CGFloat = 10
        static let iconSize: CGFloat = 24
        static let blackListLabelLeading: CGFloat = 10
        static let blockedAmountLeading: CGFloat = 10
    }
    
    // MARK: - Properties
    private let blackListIcon: UIImageView = UIImageView()
    private let blackListLabel: UILabel = UILabel()
    private let blockedAmountLabel: UILabel = UILabel()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(icon: UIImage?, title: String, amount: String) {
        blackListIcon.image = icon
        blackListLabel.text = title
        blockedAmountLabel.text = amount
    }
    
    // MARK: - Configuration
    private func configureCell() {
        configureBlackListIcon()
        configureBlackListLabel()
        configureBlockedAmountLabel()
    }
    
    private func configureBlackListIcon() {
        contentView.addSubview(blackListIcon)
        blackListIcon.contentMode = .scaleAspectFill
        blackListIcon.tintColor = .orange
        blackListIcon.pinCenterY(contentView)
        blackListIcon.pinLeft(contentView.leadingAnchor, Constants.iconLeading)
        blackListIcon.setHeight(Constants.iconSize)
        blackListIcon.setWidth(Constants.iconSize)
    }
    
    private func configureBlackListLabel() {
        contentView.addSubview(blackListLabel)
        blackListLabel.font = Fonts.systemR16
        blackListLabel.textColor = .black
        blackListLabel.pinCenterY(contentView)
        blackListLabel.pinLeft(blackListIcon.trailingAnchor, Constants.blackListLabelLeading)
    }
    
    private func configureBlockedAmountLabel() {
        contentView.addSubview(blockedAmountLabel)
        blockedAmountLabel.font = Fonts.systemR16
        blockedAmountLabel.textColor = .black
        blockedAmountLabel.pinCenterY(contentView)
        blockedAmountLabel.pinRight(contentView.trailingAnchor, Constants.blockedAmountLeading)
    }
}
