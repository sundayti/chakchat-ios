//
//  OnlineVisibilityScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import UIKit

// MARK: - OnlineVisibilityScreenPresenter
final class OnlineVisibilityScreenPresenter: OnlineVisibilityScreenPresentationLogic {
    
    // MARK: - Properties
    weak var view: OnlineVisibilityScreenViewController?
    
    // MARK: - User Data Showing
    func showUserRestrictions(_ onlineRestriction: OnlineVisibilityStatus) {
        view?.markCurrentOption(onlineRestriction)
    }
}
