//
//  NotificationCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import UIKit

// MARK: - NotificationCell
final class NotificationCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIndetifier = "NotificationCell"
    
    // MARK: - Properties
    private var notificationLabel: UILabel = UILabel()
    private var switchButton: UISwitch = UISwitch()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Point
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let switchButtonCoordinate = switchButton.coordinateSpace
        let newPoint = convert(point, to: switchButtonCoordinate)
        return switchButton.point(inside: newPoint, with: event)
    }
    
    // MARK: - Configuration
    public func configure(title: String) {
        notificationLabel.text = title
    }
    
    // MARK: - Cell Configuration
    private func configureCell() {
        configureNotificationLabel()
        configureSwitchButton()
    }
    
    // MARK: - Notification Label Configuration
    private func configureNotificationLabel() {
        contentView.addSubview(notificationLabel)
        notificationLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        notificationLabel.textColor = .black
        notificationLabel.pinCenterY(contentView)
        notificationLabel.pinLeft(contentView.leadingAnchor, 10)
    }
    
    // MARK: - Switch Button Configuration
    private func configureSwitchButton() {
        contentView.addSubview(switchButton)
        switchButton.pinCenterY(contentView)
        switchButton.pinRight(contentView.trailingAnchor, 10)
    }
}
