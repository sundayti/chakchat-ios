//
//  BirthVisibilityScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit

// MARK: - BirthVisibilityScreenAssembly
enum BirthVisibilityScreenAssembly {
    
    // MARK: - Birth Visibility Screen Assembly Method
    static func build(with context: MainAppContextProtocol, coordinator: AppCoordinator) -> UIViewController {
        let presenter = BirthVisibilityScreenPresenter()
        let worker = BirthVisibilityScreenWorker(userDeafultsManager: context.userDefaultsManager)
        let userData = getBirthVisibilityData(context.userDefaultsManager)
        let interactor = BirthVisibilityScreenInteractor(presenter: presenter, 
                                                         worker: worker,
                                                         eventManager: context.eventManager,
                                                         userData: userData,
                                                         logger: context.logger
        )
        interactor.onRouteToConfidentialityScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = BirthVisibilityScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

// MARK: - Birth Visibility Data Getting
private func getBirthVisibilityData(_ userDefaultsManager: UserDefaultsManagerProtocol) -> BirthVisibilityScreenModels.BirthVisibility {
    let birtVisibility = userDefaultsManager.loadConfidentialityDateOfBirthStatus()
    guard let birtVisibility = ConfidentialityState(rawValue: birtVisibility) else {
        return BirthVisibilityScreenModels.BirthVisibility(birthStatus: .all)
    }
    return BirthVisibilityScreenModels.BirthVisibility(birthStatus: birtVisibility)
}
