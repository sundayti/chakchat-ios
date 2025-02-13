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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.systemL14
        label.textColor = Colors.text
        return label
    }()
    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.systemR18
        label.textColor = Colors.text
        return label
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with title: String, value: String) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
    private func configureCell() {
        configureTitleLabel()
        configureValueLabel()
    }
    
    private func configureTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.pinTop(contentView, 8)
        titleLabel.pinLeft(contentView.leadingAnchor, 12)
    }
    
    private func configureValueLabel() {
        contentView.addSubview(valueLabel)
        valueLabel.pinTop(titleLabel.bottomAnchor, 5)
        valueLabel.pinLeft(contentView.leadingAnchor, 12)
        valueLabel.pinBottom(contentView, 8)
    }
}
