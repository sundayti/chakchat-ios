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
        var presenter = SettingsScreenPresenter()
        var worker = SettingsScreenWorker()
        var interactor = SettingsScreenInteractor(presenter: presenter, worker: worker)
        var view = SettingsScreenViewController(interactor: interactor)
        presenter.view = view
        return view
    }
}
