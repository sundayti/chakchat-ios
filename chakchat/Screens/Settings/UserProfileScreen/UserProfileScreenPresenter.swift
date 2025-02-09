//
//  UserProfileScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//

import Foundation
import UIKit

final class UserProfileScreenPresenter: UserProfileScreenPresentationLogic {
    
    weak var view: UserProfileScreenViewController?
    
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        view?.configureUserData(userData)
    }
    
    func showNewUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        view?.updateUserData(userData)
    }
}
