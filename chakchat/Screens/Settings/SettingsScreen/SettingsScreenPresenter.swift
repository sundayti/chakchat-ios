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
    func showUserData(_ data: SettingsScreenModels.UserData) {
        view?.configureUserData(data)
    }
    
    // MARK: - Updated User Data Showing
    func showNewUserData(_ data: SettingsScreenModels.UserData) {
        view?.updateUserData(data)
    }
}
