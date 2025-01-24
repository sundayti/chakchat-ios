//
//  SettingsScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
final class SettingsScreenInteractor: SettingsScreenBusinessLogic {
    
    var presenter: SettingsScreenPresentationLogic
    var worker: SettingsScreenWorkerLogic
    var onRouteToProfileSettings: (() -> Void)?
    
    init(presenter: SettingsScreenPresentationLogic, worker: SettingsScreenWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func profileSettingsRoute() {
        onRouteToProfileSettings?()
    }
}
