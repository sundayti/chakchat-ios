//
//  UIChakChatStackView.swift
//  chakchat
//
//  Created by Кирилл Исаев on 15.01.2025.
//

import Foundation
import UIKit
final class UIChakChatStackView: UIStackView {
    private lazy var chakLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.chakLabelText
        label.font = UIConstants.chakchatFont
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var chatLabel: UILabel = {
        let label = UILabel()
        label.text = UIConstants.chatLabelText
        label.font = UIConstants.chakchatFont
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private lazy var chakchatStackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [chakLabel, chatLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = UIConstants.chakchatStackViewSpacing
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(chakchatStackView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
