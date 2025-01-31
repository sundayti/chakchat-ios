//
//  OnlineVisibilityScreenPresenter.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import UIKit
final class OnlineVisibilityScreenPresenter: OnlineVisibilityScreenPresentationLogic {
    
    weak var view: OnlineVisibilityScreenViewController?
    
    func showUserData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility) {
        view?.markCurrentOption(onlineVisibility)
    }
}
