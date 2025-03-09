//
//  UserProfileCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.02.2025.
//

import UIKit

// MARK: - UserProfileCell
final class UserProfileCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIdentifier: String = "UserProfileCell"
    
    private enum Constants {
        static let titleLabelTop: CGFloat = 8
        static let titleLabelLeading: CGFloat = 12
        static let valueLabelTop: CGFloat = 8
        static let valueLabelLeading: CGFloat = 12
        static let valueLabelBottom: CGFloat = 8
    }
    
    // MARK: - Properties
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
        titleLabel.pinTop(contentView, Constants.titleLabelTop)
        titleLabel.pinLeft(contentView.leadingAnchor, Constants.titleLabelLeading)
    }
    
    private func configureValueLabel() {
        contentView.addSubview(valueLabel)
        valueLabel.pinTop(titleLabel.bottomAnchor, Constants.valueLabelTop)
        valueLabel.pinLeft(contentView.leadingAnchor, Constants.valueLabelLeading)
        valueLabel.pinBottom(contentView, Constants.valueLabelBottom)
    }
}
