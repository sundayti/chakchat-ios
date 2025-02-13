//
//  PhoneVisibilityScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - PhoneVisibilityScreenPresenter
final class PhoneVisibilityScreenPresenter: PhoneVisibilityScreenPresentationLogic {
    
    // MARK: - Properties
    weak var view: PhoneVisibilityScreenViewController?
    
    // MARK: - User Data Showing
    func showUserRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        view?.markCurrentOption(userRestrictions)
    }
}
