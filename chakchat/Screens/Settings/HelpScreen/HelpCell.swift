//
//  HelpCell.swift
//  chakchat
//
//  Created by лизо4ка курунок on 23.02.2025.
//

import UIKit

// MARK: - HelpCell
final class HelpCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIdentifier: String = "HelpCell"
    
    private enum Constants {
        static let titleLabelLeading: CGFloat = 12
    }
    
    // MARK: - Properties
    private var label: UILabel = {
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
    func configure(with title: String) {
        self.label.text = title
    }
    
    private func configureCell() {
        configureLabel()
    }
    
    private func configureLabel() {
        contentView.addSubview(label)
        label.pinCenterY(contentView)
        label.pinLeft(contentView.leadingAnchor, Constants.titleLabelLeading)
    }
}

