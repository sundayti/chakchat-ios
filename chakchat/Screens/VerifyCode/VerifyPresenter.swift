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
    
    // MARK: - Properties
    weak var view: VerifyViewController?
    
    // MARK: - Error Handling
    func showError(_ error: ErrorId) {
        switch error.type {
        case .Alert:
            print(error)
            showAlert(error.message)
        case .DisappearingLabel:
            view?.showError(error.message)
        case .None: break
            // Show nothing
        }
    }
    
    // MARK: - Alert Presentation
    func showAlert(_ message: String?) {
        view?.showAlert(message: message)
    }
    
    // MARK: - Phone Presentation
    func showPhone(_ phone: String) {
        view?.showPhone(phone)
    }
    
    // MARK: - Hide Resend Button 
    func hideResendButton() {
        view?.hideResendButton()
    }
}
