//
//  NotificationScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import UIKit

// MARK: - NotificationScreenPresenter
final class NotificationScreenPresenter: NotificationScreenPresentationLogic {
    
    // MARK: - Properties
    weak var view: NotificationScreenViewController?
    
    // MARK: - User Data Showing
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus) {
        view?.configureUserData(userData)
    }
}
