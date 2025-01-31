//
//  NotificationScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import UIKit

final class NotificationScreenPresenter: NotificationScreenPresentationLogic {
    
    weak var view: NotificationScreenViewController?
    
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus) {
        view?.configureUserData(userData)
    }
}
