//
//  SettingsScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
final class SettingsScreenPresenter: SettingsScreenPresentationLogic {
        
    weak var view: SettingsScreenViewController?
    
    func showUserData(_ data: SettingsScreenModels.UserData) {
        view?.configureUserData(data)
    }
    
    func showNewUserData(_ data: SettingsScreenModels.UserData) {
        view?.updateUserData(data)
    }
}
