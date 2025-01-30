//
//  BirthVisibilityScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit
final class BirthVisibilityScreenPresenter: BirthVisibilityScreenPresentationLogic {
    
    weak var view: BirthVisibilityScreenViewController?
    
    func showUserData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        view?.markCurrentOption(birthVisibility)
    }
}
