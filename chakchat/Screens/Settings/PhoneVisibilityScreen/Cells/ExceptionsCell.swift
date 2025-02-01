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
        optionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        optionLabel.textColor = .black
        optionLabel.pinCenterY(contentView)
        optionLabel.pinLeft(contentView.leadingAnchor, 10)
    }
    
    // MARK: Chevron ImageView Configuration
    private func configureChevronImageView() {
        contentView.addSubview(chevronImageView)
        chevronImageView.contentMode = .scaleAspectFill
        chevronImageView.tintColor = .gray
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.pinCenterY(contentView)
        chevronImageView.pinRight(contentView.trailingAnchor, 10)
        chevronImageView.setWidth(12)
        chevronImageView.setHeight(12)
    }
    
    // MARK: - Add Label Configuration
    private func configureAddLabel() {
        contentView.addSubview(addLabel)
        addLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        addLabel.textColor = .gray
        addLabel.text = "Add"
        addLabel.pinRight(chevronImageView.leadingAnchor, 10)
        addLabel.pinCenterY(contentView)
    }
}
