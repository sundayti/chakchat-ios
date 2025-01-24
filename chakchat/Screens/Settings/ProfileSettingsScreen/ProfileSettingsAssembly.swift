//
//  ProfileSettingsAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import UIKit
enum ProfileSettingsAssembly {
    static func build(with context: SignupContext, coordinator: AppCoordinator) -> UIViewController {
        let presenter = ProfileSettingsPresenter()
        let worker = ProfileSettingsWorker()
        let interactor = ProfileSettingsInteractor(presenter: presenter, worker: worker)
        let view = ProfileSettingsViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
