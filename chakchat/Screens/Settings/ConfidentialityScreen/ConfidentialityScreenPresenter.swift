//
//  ConfidentialityScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation

// MARK: - ConfidentialityScreenPresenter
final class ConfidentialityScreenPresenter: ConfidentialityScreenPresentationLogic {
    
    // MARK: - Properties
    weak var view: ConfidentialityScreenViewController?
    
    // MARK: - User Data Showing
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        view?.configureSections(userData)
    }
    
    // MARK: - New User Data Showing
    func showNewUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        view?.updateVisibilityStatus(userData)
    }
}
