//
//  StartViewController.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit

// MARK: - StartViewController
final class StartViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let chakchatFont: UIFont = UIFont.loadCustomFont(name: "RammettoOne-Regular", size: 100)
        static let tapFont: UIFont = UIFont.loadCustomFont(name: "Montserrat-Bold", size: 25)
        static let chakchatStackViewSpacing: CGFloat = -60
        static let tapLabelButtom: CGFloat = 50
        static let tapLabelText: String = "Tap"
        static let chakLabelText: String = "Chak"
        static let chatLabelText: String = "Chat"
        static let gradientLocation: [NSNumber] = [0.0, 0.5, 1.0]
        static let gradientStartPoint: CGPoint = CGPoint(x: 0.5, y: 0.0)
        static let gradientEndPoint: CGPoint = CGPoint(x: 0.5, y: 1.0)
        static let gradientSublayerAt: UInt32 = 0
    }
    
    // MARK: - Properties
    private lazy var startMessengerButton: UIButton = UIButton(type: .system)
    private lazy var chakLabel: UILabel = UILabel()
    private lazy var chatLabel: UILabel = UILabel()
    private lazy var tapLabel: UILabel = UILabel()
    private lazy var centerColor: UIColor = UIColor(hex: "#FFBF00") ?? UIColor.yellow
    private lazy var edgeColor: UIColor = UIColor(hex: "#FF6200") ?? UIColor.orange
    private lazy var chakchatStackView = UIStackView(arrangedSubviews: [chakLabel, chatLabel])
    private lazy var gradientBackgroundLayer: CAGradientLayer = CAGradientLayer()
    var onRouteToSendCodeScreen: ((AppState) -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        configureGradientBackgroundLayer()
        configureStartMessengerLabel()
        configureTapLabel()
    }
    
    // MARK: - Gradient Background Layer Configuration
    private func configureGradientBackgroundLayer() {
        gradientBackgroundLayer.colors = [
            edgeColor.cgColor,
            centerColor.cgColor,
            edgeColor.cgColor
        ]
        gradientBackgroundLayer.locations = Constants.gradientLocation
        gradientBackgroundLayer.startPoint = Constants.gradientStartPoint
        gradientBackgroundLayer.endPoint = Constants.gradientEndPoint
        gradientBackgroundLayer.frame = view.bounds
        view.layer.insertSublayer(gradientBackgroundLayer, at: Constants.gradientSublayerAt)
    }
    
    // MARK: - ChakChat Label Configuration
    private func configureStartMessengerLabel() {
        view.addSubview(chakLabel)
        view.addSubview(chatLabel)
        chakLabel.text = Constants.chakLabelText
        chakLabel.textAlignment = .center
        chakLabel.font = Constants.chakchatFont
        chakLabel.textColor = .black
        
        chatLabel.text = Constants.chatLabelText
        chatLabel.textAlignment = .center
        chatLabel.font = Constants.chakchatFont
        chatLabel.textColor = .black
        
        view.addSubview(chakchatStackView)
        chakchatStackView.axis = .vertical
        chakchatStackView.alignment = .center
        chakchatStackView.spacing = Constants.chakchatStackViewSpacing
        chakchatStackView.pinCenter(view)
    }
    
    // MARK: - Tap Label Configuration
    private func configureTapLabel() {
        view.addSubview(tapLabel)
        tapLabel.text = Constants.tapLabelText
        tapLabel.textAlignment = .center
        tapLabel.font = Constants.tapFont
        tapLabel.textColor = .black
        tapLabel.pinCenterX(view)
        tapLabel.pinBottom(view, Constants.tapLabelButtom)
    }
    
    // MARK: - Actions
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
        onRouteToSendCodeScreen?(AppState.sendPhoneCode)
    }
}
