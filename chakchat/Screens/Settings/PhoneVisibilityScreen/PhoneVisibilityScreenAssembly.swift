//
//  PhoneVisibilityScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit

// MARK: - PhoneVisibilityScreenAssembly
enum PhoneVisibilityScreenAssembly {
    
    // MARK: - Phone Visibility Screen Assembly Method
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = PhoneVisibilityScreenPresenter()
        let worker = PhoneVisibilityScreenWorker(userDefaultsManager: context.userDefaultsManager)
        let userData = getPhoneVisibilityData(context.userDefaultsManager)
        let interactor = PhoneVisibilityScreenInteractor(presenter: presenter, 
                                                         worker: worker,
                                                         eventManager: context.eventManager,
                                                         userData: userData,
                                                         logger: context.logger
        )
        interactor.onRouteToConfidentialityScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = PhoneVisibilityScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

// MARK: - Phone Visibility Data Getting
private func getPhoneVisibilityData(_ userDefaultsManager: UserDefaultsManagerProtocol) -> PhoneVisibilityScreenModels.PhoneVisibility {
    let phoneVisibility = userDefaultsManager.loadConfidentialityPhoneStatus()
    guard let phoneVisibility = ConfidentialityState(rawValue: phoneVisibility) else {
        return PhoneVisibilityScreenModels.PhoneVisibility(phoneStatus: .all)
    }
    return PhoneVisibilityScreenModels.PhoneVisibility(phoneStatus: phoneVisibility)
}
