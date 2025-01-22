//
//  UIViewController+Alert.swift
//  chakchat
//
//  Created by лизо4ка курунок on 22.01.2025.
//

import Foundation
import UIKit

// MARK: - UIViewController Extension
extension UIViewController {
    func showAlert(title: String = "Error", message: String?, cancelTitle: String = "Cancel") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
