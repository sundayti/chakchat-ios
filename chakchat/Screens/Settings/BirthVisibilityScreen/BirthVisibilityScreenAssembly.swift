//
//  BirthVisibilityScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import UIKit
enum BirthVisibilityScreenAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = BirthVisibilityScreenPresenter()
        let worker = BirthVisibilityScreenWorker(userDeafultsManager: context.userDefaultManager)
        let userData = getBirthVisibilityData(context.userDefaultManager)
        let interactor = BirthVisibilityScreenInteractor(presenter: presenter, worker: worker, eventManager: context.eventManager, userData: userData)
        interactor.onRouteToConfidentialityScreen = { [weak coordinator] in
            coordinator?.popScreen()
        }
        let view = BirthVisibilityScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}

private func getBirthVisibilityData(_ userDefaultsManager: UserDefaultsManagerProtocol) -> BirthVisibilityScreenModels.BirthVisibility {
    let birtVisibility = userDefaultsManager.loadConfidentialityDateOfBirthStatus()
    guard let birtVisibility = ConfidentialityState(rawValue: birtVisibility) else {
        return BirthVisibilityScreenModels.BirthVisibility(birthStatus: .all)
    }
    return BirthVisibilityScreenModels.BirthVisibility(birthStatus: birtVisibility)
}
