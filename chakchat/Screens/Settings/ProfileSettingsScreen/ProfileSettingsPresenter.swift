//
//  ProfileSettingsPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit

// MARK: - ProfileSettingsPresenter
final class ProfileSettingsPresenter: ProfileSettingsScreenPresentationLogic {
    
    // MARK: - Properties
    weak var view: ProfileSettingsViewController?
    
    // MARK: - User Data Showing
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        view?.configureUserData(userData)
    }
}
