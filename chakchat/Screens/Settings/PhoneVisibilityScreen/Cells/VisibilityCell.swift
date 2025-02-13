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
    
    private enum Constants {
        static let currentOptionName: String = "checkmark"
        static let currentOptionSize: CGFloat = 20
        static let currentOptionTrailing: CGFloat = 10
        static let visibilityOptionLeading: CGFloat = 10
    }
    
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
        currentOptionImageView.image = UIImage(systemName: Constants.currentOptionName)
        currentOptionImageView.setHeight(Constants.currentOptionSize)
        currentOptionImageView.setWidth(Constants.currentOptionSize)
        currentOptionImageView.pinCenterY(contentView)
        currentOptionImageView.pinRight(contentView, Constants.currentOptionTrailing)
    }
    
    // MARK: - Visibility Option Label Configuration
    private func configureVisibilityOptionLabel() {
        contentView.addSubview(visibilityOptionLabel)
        visibilityOptionLabel.font = Fonts.systemR16
        visibilityOptionLabel.textColor = Colors.text
        visibilityOptionLabel.pinCenterY(contentView)
        visibilityOptionLabel.pinLeft(contentView, Constants.visibilityOptionLeading)
    }
}
