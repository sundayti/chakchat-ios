//
//  ChatPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 03.03.2025.
//

import UIKit

final class ChatPresenter: ChatPresentationLogic {
    weak var view: ChatViewController?
    
    func passUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        view?.configureWithData(userData)
    }
}
