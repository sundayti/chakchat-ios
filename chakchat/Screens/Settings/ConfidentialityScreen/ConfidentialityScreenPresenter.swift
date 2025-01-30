//
//  ConfidentialityScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
final class ConfidentialityScreenPresenter: ConfidentialityScreenPresentationLogic {
    
    weak var view: ConfidentialityScreenViewController?
    
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        view?.configureSections(userData)
    }
}
