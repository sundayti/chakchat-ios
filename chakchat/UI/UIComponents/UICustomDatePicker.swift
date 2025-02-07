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
        static let resetTitle: String = "Reset"
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
    var delegate: (_ date: Date?) -> Void = { _ in }
    var settedDate: Date {
        get { datePicker.date }
        set { datePicker.date = newValue }
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

    private func configure() {
        backgroundColor = Colors.blackout
        configureFrame()
        configurateTitle()
        configureDatePicker()
        configureResetButton()
        configureOKButton()
    }
    
    // MARK: - Frame Configuration
    private func configureFrame() {
        frameView.layer.cornerRadius = Constants.frameCornerRadius
        frameView.layer.masksToBounds = true
        frameView.backgroundColor = .white
        addSubview(frameView)
        frameView.pinLeft(self, Constants.frameX)
        frameView.pinRight(self, Constants.frameX)
        frameView.pinCenterY(self)
        frameView.setHeight(Constants.frameHeight)
        frameView.setWidth(Constants.frameWidth)
    }
    
    // MARK: - Title Configuration
    private func configurateTitle() {
        titleLabel.font = Fonts.systemB16
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        frameView.addSubview(titleLabel)
        titleLabel.pinTop(frameView, Constants.titleTop)
        titleLabel.pinCenterX(frameView)
    }
    
    // MARK: - DatePicker Configuration
    private func configureDatePicker() {
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.date = settedDate
        datePicker.maximumDate = Date()
        frameView.addSubview(datePicker)
        datePicker.pinTop(titleLabel.bottomAnchor, Constants.datePickerTop)
        datePicker.pinCenterX(frameView)
    }
    
    // MARK: - Reset Button Configuration
    private func configureResetButton() {
        resetButton.setTitle(Constants.resetTitle, for: .normal)
        resetButton.setTitleColor(UIColor.systemBlue, for: .normal)
        resetButton.addTarget(self, action: #selector(resetPressed), for: .touchUpInside)
        frameView.addSubview(resetButton)
        resetButton.pinTop(datePicker.bottomAnchor, Constants.buttonTop)
        resetButton.pinLeft(frameView, Constants.buttonX)
        resetButton.setHeight(Constants.buttonHeight)
    }
    
    // MARK: - OK Button Configuration
    private func configureOKButton() {
        okButton.setTitle(Constants.okTitle, for: .normal)
        okButton.setTitleColor(UIColor.systemBlue, for: .normal)
        okButton.addTarget(self, action: #selector(okPressed), for: .touchUpInside)
        frameView.addSubview(okButton)
        okButton.pinTop(datePicker.bottomAnchor, Constants.buttonTop)
        okButton.pinRight(frameView, Constants.buttonX)
        okButton.setHeight(Constants.buttonHeight)
    }
    
    // MARK: - Disappering if buttons were pressed
    private func disappearAndReturn(date: Date?) {
        self.alpha = 0.0
        self.removeFromSuperview()
        self.delegate(date)
    }
    
    // MARK: - Actions
    @objc
    func resetPressed() {
        disappearAndReturn(date: nil)
    }
      
    @objc
    func okPressed() {
        disappearAndReturn(date: datePicker.date)
    }
      
    // MARK: - Create Picker and Show
    static func createAndShow(in viewController: UIViewController, title: String, settedDate: Date, delegate: @escaping (_ date: Date?) -> Void) -> UICustomDatePicker {
        let picker = UICustomDatePicker(frame: viewController.view.bounds)
        picker.title = title
        picker.delegate = delegate
        picker.settedDate = settedDate
        viewController.view.addSubview(picker)
        
        return picker
    }
}
