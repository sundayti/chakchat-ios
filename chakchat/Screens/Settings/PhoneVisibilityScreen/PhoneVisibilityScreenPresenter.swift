//
//  PhoneVisibilityScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class PhoneVisibilityScreenPresenter: PhoneVisibilityScreenPresentationLogic {
    
    weak var view: PhoneVisibilityScreenViewController?
    
    func showUserData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility) {
        view?.markCurrentOption(phoneVisibility)
    }
}
