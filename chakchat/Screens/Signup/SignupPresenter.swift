//
//  SignupPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit
class SignupPresenter: SignupPresentationLogic {

    weak var view: SignupViewController?
    
    func showError(_ error: ErrorId) {
        switch error.type {
        case .Alert:
            showAlert(error.message)
        case .DisappearingLabel:
            view?.showError(error.message)
        case .None: break
            // Show nothing
        }
    }
    
    func showAlert(_ message: String?) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        view?.present(alert, animated: true, completion: nil)
    }
}
