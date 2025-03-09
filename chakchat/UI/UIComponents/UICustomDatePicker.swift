//
//  UICustomDatePicker.swift
//  chakchat
//
//  Created by лизо4ка курунок on 06.02.2025.
//

import UIKit

// MARK: - UICustomDatePicker
final class UICustomDatePicker : UIView {
    
    // MARK: - Constants
    private enum Constants {
        static let frameCornerRadius: CGFloat = 10
        static let frameX: CGFloat = 20
        static let frameHeight: CGFloat = 430
        static let frameWidth: CGFloat = 350
        static let titleTop: CGFloat = 20
        static let datePickerTop: CGFloat = 10
        static let okTitle: String = "OK"
        static let buttonTop: CGFloat = 0
        static let buttonX: CGFloat = 60
        static let buttonHeight: CGFloat = 40
    }
    
    // MARK: - Properties
    private var frameView: UIView = UIView()
    private var titleLabel: UILabel = UILabel()
    private var datePicker: UIDatePicker = UIDatePicker()
    private var okButton: UIButton = UIButton()
    private var resetButton: UIButton = UIButton()
    
    var delegate: ((_ date: Date?) -> Void)?
    var settedDate: Date? {
        get { datePicker.date }
        set { datePicker.date = newValue ?? Date() }
    }
    var title: String {
        get { titleLabel.text ?? "" }
        set { titleLabel.text = newValue }
    }
        
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    // MARK: - Configuration
    private func configure() {
        backgroundColor = Colors.blackout
        configureFrame()
        configurateTitle()
        configureDatePicker()
        configureResetButton()
        configureOKButton()
    }
    
    private func configureFrame() {
        addSubview(frameView)
        frameView.layer.cornerRadius = Constants.frameCornerRadius
        frameView.layer.masksToBounds = true
        frameView.backgroundColor = Colors.picker
        
        frameView.pinLeft(self, Constants.frameX)
        frameView.pinRight(self, Constants.frameX)
        frameView.pinCenterY(self)
        frameView.setHeight(Constants.frameHeight)
        frameView.setWidth(Constants.frameWidth)
    }
    
    private func configurateTitle() {
        frameView.addSubview(titleLabel)
        titleLabel.font = Fonts.systemB16
        titleLabel.textColor = Colors.text
        titleLabel.textAlignment = .center
        
        titleLabel.pinTop(frameView, Constants.titleTop)
        titleLabel.pinCenterX(frameView)
    }
    
    private func configureDatePicker() {
        frameView.addSubview(datePicker)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.date = settedDate ?? Date()
        datePicker.maximumDate = Date()
        datePicker.locale = LocalizationManager.shared.getLocale()
        
        datePicker.pinTop(titleLabel.bottomAnchor, Constants.datePickerTop)
        datePicker.pinCenterX(frameView)
    }
    
    private func configureResetButton() {
        frameView.addSubview(resetButton)
        resetButton.setTitle(LocalizationManager.shared.localizedString(for: "reset"), for: .normal)
        resetButton.setTitleColor(UIColor.systemBlue, for: .normal)
        resetButton.addTarget(self, action: #selector(resetPressed), for: .touchUpInside)
        
        resetButton.pinTop(datePicker.bottomAnchor, Constants.buttonTop)
        resetButton.pinLeft(frameView, Constants.buttonX)
        resetButton.setHeight(Constants.buttonHeight)
    }

    private func configureOKButton() {
        frameView.addSubview(okButton)
        okButton.setTitle(Constants.okTitle, for: .normal)
        okButton.setTitleColor(UIColor.systemBlue, for: .normal)
        okButton.addTarget(self, action: #selector(okPressed), for: .touchUpInside)
        okButton.pinTop(datePicker.bottomAnchor, Constants.buttonTop)
        okButton.pinRight(frameView, Constants.buttonX)
        okButton.setHeight(Constants.buttonHeight)
    }
    
    // MARK: - Disappering if buttons were pressed
    private func disappear(date: Date?) {
        self.alpha = 0.0
        self.removeFromSuperview()
        self.delegate?(date)
    }
    
    // MARK: - Actions
    @objc
    func resetPressed() {
        disappear(date: nil)
    }
      
    @objc
    func okPressed() {
        disappear(date: datePicker.date)
    }
}
