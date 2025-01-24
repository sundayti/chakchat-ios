//
//  UIDeletableTextField.swift
//  chakchat
//
//  Created by лизо4ка курунок on 25.01.2025.
//

import UIKit

// MARK: - UIDeletableTextField
// Special class so that when you press backspace the cursor moves to the cell to the left (if the cell is empty).
final class UIDeletableTextField: UITextField {
    
    // MARK: - Override Delete Backward
    override public func deleteBackward() {
        super.deleteBackward()
        if let previousTextField = getPreviousTextField() {
            previousTextField.becomeFirstResponder()
        }
    }
    
    // MARK: - Get Previous Text Field
    private func getPreviousTextField() -> UITextField? {
        let currentTag = self.tag
        let previousTag = currentTag - 1
        return self.superview?.viewWithTag(previousTag) as? UITextField
    }
}
