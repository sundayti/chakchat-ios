//
//  MockSendCodePresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 16.01.2025.
//

import Foundation

// MARK: - MockSendCodePresenter
final class MockSendCodePresenter: SendCodePresentationLogic {
    
    // MARK: - Properties
    var errorMessage: String?
    var isErrorShown = false
    
    // MARK: - Error Handling
    func showError(_ error: ErrorId) {
        errorMessage = error.message
        isErrorShown = true
    }
}
