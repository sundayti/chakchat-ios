//
//  UINewGroupTitleLabel.swift
//  chakchat
//
//  Created by лизо4ка курунок on 25.02.2025.
//

import UIKit

// MARK: - UINewGroupTitleLabel
final class UINewGroupTitleLabel: UIView {
    
    // MARK: - Properties
    private let titleLabel: UILabel = UILabel()
    private let subtitleLabel: UILabel = UILabel()
    private var stackView: UIStackView = UIStackView()
    private let maxUsers: Int = 1000
    private var currentUsers: Int = 0
    
    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCounter(_ value: Int) {
        currentUsers = value
        subtitleLabel.text = "\(currentUsers)/\(maxUsers)"
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureTitle()
        configureSubtitle()
        configureStackView()
    }
    
    // MARK: - Title Configuration
    private func configureTitle() {
        titleLabel.font = Fonts.systemSB18
        titleLabel.textColor = Colors.text
        titleLabel.text = LocalizationManager.shared.localizedString(for: "new_group")
        titleLabel.textAlignment = .center
    }
    
    // MARK: - Subtitle (counter) configuration
    private func configureSubtitle() {
        subtitleLabel.font = Fonts.systemR12
        subtitleLabel.text = "\(currentUsers)/\(maxUsers)"
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .gray
    }
    
    // MARK: - StackView Configuration
    private func configureStackView() {
        stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.pinTop(self.topAnchor, 0)
        stackView.pinBottom(self.bottomAnchor, 0)
        stackView.pinLeft(self.leadingAnchor, 0)
        stackView.pinRight(self.trailingAnchor, 0)
    }
}
