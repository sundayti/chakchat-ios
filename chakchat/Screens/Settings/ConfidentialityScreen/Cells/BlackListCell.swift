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
    
    // MARK: - Configuration
    public func configure(icon: UIImage?, title: String, amount: String) {
        blackListIcon.image = icon
        blackListLabel.text = title
        blockedAmountLabel.text = amount
    }
    
    // MARK: - Cell Configuration
    private func configureCell() {
        configureBlackListIcon()
        configureBlackListLabel()
        configureBlockedAmountLabel()
    }
    
    // MARK: - Black List Icon Configuration
    private func configureBlackListIcon() {
        contentView.addSubview(blackListIcon)
        blackListIcon.contentMode = .scaleAspectFill
        blackListIcon.tintColor = .orange
        blackListIcon.pinCenterY(contentView)
        blackListIcon.pinLeft(contentView.leadingAnchor, 10)
        blackListIcon.setHeight(24)
        blackListIcon.setWidth(24)
    }
    
    // MARK: - Black List Label Configuration
    private func configureBlackListLabel() {
        contentView.addSubview(blackListLabel)
        blackListLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        blackListLabel.textColor = .black
        blackListLabel.pinCenterY(contentView)
        blackListLabel.pinLeft(blackListIcon.trailingAnchor, 10)
    }
    
    // MARK: - Blocked Amount Label Configuration
    private func configureBlockedAmountLabel() {
        contentView.addSubview(blockedAmountLabel)
        blockedAmountLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        blockedAmountLabel.textColor = .black
        blockedAmountLabel.pinCenterY(contentView)
        blockedAmountLabel.pinRight(contentView.trailingAnchor, 10)
    }
}
