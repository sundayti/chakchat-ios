//
//  RegistrationPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 07.01.2025.
//

import Foundation
import UIKit

// MARK: - SendCodePresenter
class SendCodePresenter: SendCodePresentationLogic {
    
    // MARK: - Properties
    weak var view: SendCodeViewController?
    
    // MARK: - Error Handling
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
    
    // MARK: - Alert Presentation
    func showAlert(_ message: String?) {
        view?.showAlert(message: message)
    }
}
