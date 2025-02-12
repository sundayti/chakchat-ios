//
//  SettingsScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation

// MARK: - SettingsScreenPresenter
final class SettingsScreenPresenter: SettingsScreenPresentationLogic {

    
    // MARK: - Properties
    weak var view: SettingsScreenViewController?
    
    // MARK: - User Data Showing
    func showUserData(_ data: ProfileSettingsModels.ProfileUserData) {
        view?.configureUserData(data)
    }
    
    func showNewUserData(_ data: ProfileSettingsModels.ChangeableProfileUserData) {
        view?.updateUserData(data)
    }
}
