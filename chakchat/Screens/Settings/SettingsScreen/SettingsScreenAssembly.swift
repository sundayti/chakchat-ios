//
//  SettingsScreenAssembly.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import UIKit
enum SettingsScreenAssembly {
    static func build() -> UIViewController {
        let presenter = SettingsScreenPresenter()
        let worker = SettingsScreenWorker()
        let interactor = SettingsScreenInteractor(presenter: presenter, worker: worker)
        let view = SettingsScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
