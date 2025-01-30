//
//  PhoneVisibilityCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit
final class VisibilityCell: UITableViewCell {
    
    static let cellIdentifier = "VisibilityCell"
    
    private var visibilityOptionLabel: UILabel = UILabel()
    private var currentOptionImageView: UIImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    public func configure(title: String, isSelected: Bool) {
        visibilityOptionLabel.text = title
        currentOptionImageView.isHidden = !isSelected
    }
    
    private func configureCell() {
        configureCurrentOptionImageView()
        configureVisibilityOptionLabel()
    }
    
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
    
    private func configureVisibilityOptionLabel() {
        contentView.addSubview(visibilityOptionLabel)
        visibilityOptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        visibilityOptionLabel.textColor = .black
        visibilityOptionLabel.pinCenterY(contentView)
        visibilityOptionLabel.pinLeft(currentOptionImageView.trailingAnchor, 16)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
