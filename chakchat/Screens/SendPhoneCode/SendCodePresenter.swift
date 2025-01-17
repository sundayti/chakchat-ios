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
    
    weak var view: SendCodeViewController?
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.getErrorMessage, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        view?.present(alert, animated: true, completion: nil)
    }
}
