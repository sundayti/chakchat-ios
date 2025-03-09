//
//  NotificationCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import UIKit

// MARK: - NotificationCellDelegate
protocol NotificationCellDelegate: AnyObject {
    func switchDidToggle(cell: NotificationCell, isOn: Bool)
}

// MARK: - NotificationCell
final class NotificationCell: UITableViewCell {
    
    // MARK: - Constants
    static let cellIndetifier = "NotificationCell"
    
    private enum Constants {
        static let notificationLabelLeading: CGFloat = 10
        static let switchButtonTrailing: CGFloat = 20
    }
    
    // MARK: - Properties
    weak var notificationDelegate: NotificationCellDelegate?
    
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
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let switchButtonCoordinate = switchButton.coordinateSpace
        let newPoint = convert(point, to: switchButtonCoordinate)
        return switchButton.point(inside: newPoint, with: event)
    }
    
    // MARK: - Public Methods
    func configure(title: String) {
        notificationLabel.text = title
    }
    
    func configureSwitch(isOn: Bool) {
        switchButton.isOn = isOn
    }
    
    // MARK: - Configuration
    private func configureCell() {
        configureNotificationLabel()
        configureSwitchButton()
    }
    
    private func configureNotificationLabel() {
        contentView.addSubview(notificationLabel)
        notificationLabel.font = Fonts.systemR16
        notificationLabel.textColor = Colors.text
        notificationLabel.pinCenterY(contentView)
        notificationLabel.pinLeft(contentView.leadingAnchor, Constants.notificationLabelLeading)
    }
    
    private func configureSwitchButton() {
        contentView.addSubview(switchButton)
        switchButton.pinCenterY(contentView)
        switchButton.pinRight(contentView.trailingAnchor, Constants.switchButtonTrailing)
        switchButton.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        switchButton.onTintColor = Colors.lightOrange
    }
    
    // MARK: - Actions
    @objc
    private func switchValueChanged(_ sender: UISwitch) {
        notificationDelegate?.switchDidToggle(cell: self, isOn: sender.isOn)
    }
}
