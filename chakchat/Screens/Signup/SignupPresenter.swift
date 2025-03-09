//
//  SignupPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 09.01.2025.
//

import Foundation
import UIKit

// MARK: - SignupPresenter
final class SignupPresenter: SignupPresentationLogic {

    // MARK: - Properties
    weak var view: SignupViewController?
    
    // MARK: - Public Methods
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
        view?.showAlert(message: message)
    }
}
