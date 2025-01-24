//
//  UIPhoneNumberTextField.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.01.2025.
//

import UIKit

// MARK: - PhoneNumberTextField
final class UIPhoneNumberTextField: UITextField, UITextFieldDelegate {
    
    // MARK: - Constants
    private enum Constants {
        static let paddingX: CGFloat = 0
        static let paddingY: CGFloat = 0
        static let paddingWidth: CGFloat = 10
        static let cornerRadius: CGFloat = 8
        static let borderWidth: CGFloat = 1
        static let height: CGFloat = 60
        static let width: CGFloat = 300
        static let font: UIFont = UIFont.loadCustomFont(name: "OpenSans-Regular", size: 28)
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
        self.keyboardType = .numberPad
        self.delegate = self
        self.font = Constants.font
        self.text = "+7 9"
        self.borderStyle = .none
        self.leftViewMode = .always
        self.keyboardType = .numberPad
        self.borderStyle = .roundedRect
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = Constants.borderWidth
        self.setHeight(Constants.height)
        self.setWidth(Constants.width)
        self.layer.borderColor = Colors.gray.cgColor
        
        let paddingView = UIView(
            frame: CGRect(
                x: Constants.paddingX,
                y: Constants.paddingY,
                width: Constants.paddingWidth,
                height: self.frame.height
            )
        )
        self.leftView = paddingView
        
        self.addTarget(self, action: #selector(formatPhoneNumber), for: .editingChanged)
    }
    
    // MARK: - Phone Number Formatting
    @objc private func formatPhoneNumber() {
        guard let selectedRange = self.selectedTextRange else { return }
        let cursorOffset = self.offset(from: self.beginningOfDocument, to: selectedRange.start)
        
        
        // Delete not numbers.
        let rawNumber = self.text?.replacingOccurrences(of: "\\D", with: "", options: .regularExpression) ?? ""
        
        // Chack if number starts with 79
        guard rawNumber.hasPrefix("79") else {
            self.text = "+7 9"
            return
        }
        
        // Limit the number length to 11 digits (79XXXXXXXXX)
        let maxDigits = 11
        let trimmedNumber = String(rawNumber.prefix(maxDigits))
        
        // We format the number in the format "+7 9XX XXX XX XX"
        var formattedNumber = "+7 9"
        if trimmedNumber.count > 2 {
            formattedNumber += String(trimmedNumber.dropFirst(2))
        }
        
        // Add the spaces.
        if formattedNumber.count > 6 {
            formattedNumber.insert(" ", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: 6))
        }
        if formattedNumber.count > 10 {
            formattedNumber.insert(" ", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: 10))
        }
        if formattedNumber.count > 13 {
            formattedNumber.insert(" ", at: formattedNumber.index(formattedNumber.startIndex, offsetBy: 13))
        }
        
        // Updating the text.
        self.text = formattedNumber
        
        // Correct cursor position.
        var newCursorOffset = cursorOffset
        
        if cursorOffset == 7 {
            newCursorOffset += 1
        }
        if cursorOffset == 11 {
            newCursorOffset += 1
        }
        if cursorOffset == 14 {
            newCursorOffset += 1
        }
        
        // Set new cursor position.
        if let newPosition = self.position(from: self.beginningOfDocument, offset: newCursorOffset) {
            self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
        }
    }
    
    // MARK: - Defining behavior when deleting characters
    override public func deleteBackward() {
        guard let selectedRange = self.selectedTextRange else {
            super.deleteBackward()
            return
        }
        
        let isTextSelected = selectedRange.start != selectedRange.end

        if isTextSelected {
            super.deleteBackward()
            return
        }

        let cursorOffset = self.offset(from: self.beginningOfDocument, to: selectedRange.start)

        var offset = 0
        
        if (1...3).contains(cursorOffset) {
            // If the cursor is somewhere between + and the first 9, do nothing.
            return
        } else if Set([7, 11, 14]).contains(cursorOffset) {
            // If the cursor on the place +7 9xx |xxx |xx |xx, delete space and number.
            super.deleteBackward()
            super.deleteBackward()
            offset = -2
        } else {
            // If the cursor on another position, delete number and move cursor.
            super.deleteBackward()
            offset = -1
        }
        
        // Set new position.
        if let newPosition = self.position(from: selectedRange.start, offset: offset) {
            self.selectedTextRange = self.textRange(from: newPosition, to: newPosition)
        }
    }
}

