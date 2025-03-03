//
//  UserProfilePresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit

final class UserProfilePresenter: UserProfilePresentationLogic {
    weak var view: UserProfileViewController?
    
    func passUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        view?.configureWithUserData(userData)
    }
}
