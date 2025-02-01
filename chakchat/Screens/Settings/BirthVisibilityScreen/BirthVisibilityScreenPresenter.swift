//
//  BirthVisibilityScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit

// MARK: - BirthVisibilityScreenPresenter
final class BirthVisibilityScreenPresenter: BirthVisibilityScreenPresentationLogic {
    
    // MARK: - Properties
    weak var view: BirthVisibilityScreenViewController?
    
    // MARK: - User Data Showing
    func showUserData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        view?.markCurrentOption(birthVisibility)
    }
}
