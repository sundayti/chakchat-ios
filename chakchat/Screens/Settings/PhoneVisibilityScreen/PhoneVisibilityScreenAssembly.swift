//
//  PhoneVisibilityScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit
enum PhoneVisibilityScreenAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = PhoneVisibilityScreenPresenter()
        let worker = PhoneVisibilityScreenWorker(userDefaultsManager: context.userDefaultManager)
        let userData = getPhoneVisibilityData(context.userDefaultManager)
        let interactor = PhoneVisibilityScreenInteractor(presenter: presenter, worker: worker, eventManager: context.eventManager, userData: userData)
        interactor.onRouteToConfidentialityScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = PhoneVisibilityScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

private func getPhoneVisibilityData(_ userDefaultsManager: UserDefaultsManagerProtocol) -> PhoneVisibilityScreenModels.PhoneVisibility {
    let phoneVisibility = userDefaultsManager.loadConfidentialityPhoneStatus()
    guard let phoneVisibility = ConfidentialityState(rawValue: phoneVisibility) else {
        return PhoneVisibilityScreenModels.PhoneVisibility(phoneStatus: .all)
    }
    return PhoneVisibilityScreenModels.PhoneVisibility(phoneStatus: phoneVisibility)
}
