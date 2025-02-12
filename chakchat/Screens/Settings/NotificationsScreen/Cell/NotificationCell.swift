//
//  NotificationCell.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import UIKit

protocol NotificationCellDelegate: AnyObject {
    func switchDidToggle(cell: NotificationCell, isOn: Bool)
}

final class NotificationCell: UITableViewCell {
    
    static let cellIndetifier = "NotificationCell"
    
    weak var notificationDelegate: NotificationCellDelegate?
    
    private var notificationLabel: UILabel = UILabel()
    private var switchButton: UISwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let switchButtonCoordinate = switchButton.coordinateSpace
        let newPoint = convert(point, to: switchButtonCoordinate)
        return switchButton.point(inside: newPoint, with: event)
    }
    
    public func configure(title: String) {
        notificationLabel.text = title
    }
    
    public func configureSwitch(isOn: Bool) {
        switchButton.isOn = isOn
    }
    
    private func configureCell() {
        configureNotificationLabel()
        configureSwitchButton()
    }
    
    private func configureNotificationLabel() {
        contentView.addSubview(notificationLabel)
        notificationLabel.font = Fonts.systemR16
        notificationLabel.textColor = .black
        notificationLabel.pinCenterY(contentView)
        notificationLabel.pinLeft(contentView.leadingAnchor, 10)
    }
    
    private func configureSwitchButton() {
        contentView.addSubview(switchButton)
        switchButton.pinCenterY(contentView)
        switchButton.pinRight(contentView.trailingAnchor, 10)
        switchButton.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        switchButton.onTintColor = Colors.lightOrange
    }
    
    @objc
    private func switchValueChanged(_ sender: UISwitch) {
        notificationDelegate?.switchDidToggle(cell: self, isOn: sender.isOn)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
