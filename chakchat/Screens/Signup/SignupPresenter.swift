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
    
    func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: getErrorMessage(error), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        view?.present(alert, animated: true, completion: nil)
    }

    func getErrorMessage(_ error: Error) -> String {
        if error is APIError {
            return "Server error. Please send us an email with the error details to chakkchatt@yandex.ru"
        }

        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                return "No Internet connection. Try later."
            case .timedOut:
                return "The wait time has expired. Try again."
            default:
                return "Unknown error. Please send us an email with the error details to chakkchatt@yandex.ru"
            }
        }

        return "Unknown error. Please send us an email with the error details to chakkchatt@yandex.ru"
    }
}
