//
//  ExceptionsCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit
final class ExceptionsCell: UITableViewCell {
    
    static let cellIdentifier = "ExceptionCell"
    
    private let optionLabel: UILabel = UILabel()
    private let chevronImageView: UIImageView = UIImageView()
    private let addLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    public func configure(title: String) {
        optionLabel.text = title
    }
    
    private func configureCell() {
        configureOptionLabel()
        configureChevronImageView()
        configureAddLabel()
    }
    
    private func configureOptionLabel() {
        contentView.addSubview(optionLabel)
        optionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        optionLabel.textColor = .black
        optionLabel.pinCenterY(contentView)
        optionLabel.pinLeft(contentView.leadingAnchor, 10)
    }
    
    
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
    
    private func configureAddLabel() {
        contentView.addSubview(addLabel)
        addLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        addLabel.textColor = .gray
        addLabel.text = "Add"
        addLabel.pinRight(chevronImageView.leadingAnchor, 10)
        addLabel.pinCenterY(contentView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
