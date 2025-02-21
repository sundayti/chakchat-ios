//
//  ExceptionsCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit

// MARK: - ExceptionsCell
final class ExceptionsCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIdentifier = "ExceptionCell"
    
    private enum Constants {
        static let optionLabelLeading: CGFloat = 10
        static let chevronName: String = "chevron.right"
        static let chevronTrailing: CGFloat = 10
        static let chevronSize: CGFloat = 12
        static let addLabelText: String = LocalizationManager.shared.localizedString(for: "add")
        static let addLabelTrailing: CGFloat = 10
    }
    
    // MARK: - Properties
    private let optionLabel: UILabel = UILabel()
    private let chevronImageView: UIImageView = UIImageView()
    private let addLabel: UILabel = UILabel()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    public func configure(title: String) {
        optionLabel.text = title
    }
    
    // MARK: - Cell Configuration
    private func configureCell() {
        configureOptionLabel()
        configureChevronImageView()
        configureAddLabel()
    }
    
    // MARK: - Option Label Configuration
    private func configureOptionLabel() {
        contentView.addSubview(optionLabel)
        optionLabel.font = Fonts.systemR16
        optionLabel.textColor = Colors.text
        optionLabel.pinCenterY(contentView)
        optionLabel.pinLeft(contentView.leadingAnchor, Constants.optionLabelLeading)
    }
    
    // MARK: Chevron ImageView Configuration
    private func configureChevronImageView() {
        contentView.addSubview(chevronImageView)
        chevronImageView.contentMode = .scaleAspectFill
        chevronImageView.tintColor = .gray
        chevronImageView.image = UIImage(systemName: Constants.chevronName)
        chevronImageView.pinCenterY(contentView)
        chevronImageView.pinRight(contentView.trailingAnchor, Constants.chevronTrailing)
        chevronImageView.setWidth(Constants.chevronSize)
        chevronImageView.setHeight(Constants.chevronSize)
    }
    
    // MARK: - Add Label Configuration
    private func configureAddLabel() {
        contentView.addSubview(addLabel)
        addLabel.font = Fonts.systemR16
        addLabel.textColor = .gray
        addLabel.text = Constants.addLabelText
        addLabel.pinRight(chevronImageView.leadingAnchor, Constants.addLabelTrailing)
        addLabel.pinCenterY(contentView)
    }
}
