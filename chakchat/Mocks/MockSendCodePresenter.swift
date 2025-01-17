//
//  MockSendCodePresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation
import UIKit
class MockSendCodePresenter: SendCodePresentationLogic {
    
    var errorMessage: String?
    var isErrorShown = false
    
    func showError(_ error: ErrorId) {
        errorMessage = error.message
        isErrorShown = true
    }
}
