//
//  PhoneVisibilityCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit

// MARK: - VisibilityCell
final class VisibilityCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIdentifier = "VisibilityCell"
    
    // MARK: - Properties
    private var visibilityOptionLabel: UILabel = UILabel()
    private var currentOptionImageView: UIImageView = UIImageView()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    public func configure(title: String, isSelected: Bool) {
        visibilityOptionLabel.text = title
        currentOptionImageView.isHidden = !isSelected
    }
    
    // MARK: - Cell Configuration
    private func configureCell() {
        configureCurrentOptionImageView()
        configureVisibilityOptionLabel()
    }
    
    // MARK: - Current Option ImageView Configuration
    private func configureCurrentOptionImageView() {
        contentView.addSubview(currentOptionImageView)
        currentOptionImageView.contentMode = .scaleAspectFill
        currentOptionImageView.tintColor = .orange
        currentOptionImageView.image = UIImage(systemName: "checkmark")
        currentOptionImageView.setHeight(20)
        currentOptionImageView.setWidth(20)
        currentOptionImageView.pinCenterY(contentView)
        currentOptionImageView.pinLeft(contentView, 24)
    }
    
    // MARK: - Visibility Option Label Configuration
    private func configureVisibilityOptionLabel() {
        contentView.addSubview(visibilityOptionLabel)
        visibilityOptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        visibilityOptionLabel.textColor = .black
        visibilityOptionLabel.pinCenterY(contentView)
        visibilityOptionLabel.pinLeft(currentOptionImageView.trailingAnchor, 16)
    }
}
