//
//  VerifyPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 08.01.2025.
//

import Foundation
import UIKit

// MARK: - VerifyPresenter
final class VerifyPresenter: VerifyPresentationLogic {

    weak var view: VerifyViewController?
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.getErrorMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        view?.present(alert, animated: true, completion: nil)
    }
}
