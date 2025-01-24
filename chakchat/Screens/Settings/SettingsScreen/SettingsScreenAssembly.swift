//
//  SettingsScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit
enum SettingsScreenAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = SettingsScreenPresenter()
        let worker = SettingsScreenWorker()
        let interactor = SettingsScreenInteractor(presenter: presenter, worker: worker)
        interactor.onRouteToProfileSettings = { [weak coordinator] in
            coordinator?.showProfileSettingsScreen()
        }
        let view = SettingsScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
