//
//  UsersSearchPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.02.2025.
//

import Foundation

final class UsersSearchPresenter: UsersSearchPresentationLogic {
    weak var view: UsersSearchViewController?
    
    func showUsers(_ users: ProfileSettingsModels.Users) {
        view?.showUsers(users)
    }
}
