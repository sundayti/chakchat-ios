//
//  UserProfileCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.02.2025.
//

import Foundation
import UIKit

final class UserProfileCell: UITableViewCell {
    
    static let cellIdentifier: String = "UserProfileCell"
    
    private var titleLabel: UILabel = UILabel()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with title: String) {
        self.titleLabel.text = title
    }
    
    private func configureCell() {
        configureTitleLabel()
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel.textColor = .black
        titleLabel.pinCenterY(contentView)
        titleLabel.pinLeft(contentView.leadingAnchor, 12)
    }
}
