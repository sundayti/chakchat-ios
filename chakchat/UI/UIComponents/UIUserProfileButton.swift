//
//  UIUserProfileButton.swift
//  chakchat
//
//  Created by лизо4ка курунок on 08.03.2025.
//

import UIKit

// MARK: - UIUserProfileButton
final class UIUserProfileButton: UIButton {
    
    // MARK: - Constants
    private enum Constants {
        static let imageTop: CGFloat = 5
        static let imageSize: CGFloat = 24
        static let titleTop: CGFloat = 1
        static let titleBottom: CGFloat = 5
    }
    
    // MARK: - Properties
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabelCustom: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .label
        return label
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    // MARK: - Confoguration
    func configure(withSymbol systemName: String, title: String) {
        iconImageView.image = UIImage(systemName: systemName)
        titleLabelCustom.text = title
    }
    
    // MARK: - View Configuration
    private func configureView() {
        addSubview(iconImageView)
        addSubview(titleLabelCustom)
        
        iconImageView.pinCenterX(self)
        iconImageView.pinTop(self, Constants.imageTop)
        iconImageView.setWidth(Constants.imageSize)
        iconImageView.setHeight(Constants.imageSize)
        
        titleLabelCustom.pinCenterX(self)
        titleLabelCustom.pinTop(iconImageView.bottomAnchor, Constants.imageTop)
        titleLabelCustom.pinBottom(self, Constants.titleBottom)
    }
}
