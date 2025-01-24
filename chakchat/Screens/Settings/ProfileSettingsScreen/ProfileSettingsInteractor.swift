//
//  ProfileSettingsInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
final class ProfileSettingsInteractor: ProfileSettingsBusinessLogic {
    
    var presenter: ProfileSettingsPresentationLogic
    var worker: ProfileSettingsWorkerLogic
    var onRouteToSettingsMenu: (() -> Void)?
    
    init(presenter: ProfileSettingsPresentationLogic, worker: ProfileSettingsWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
    
    func saveNewData() {
        // save new data by using userDefaults and eventManager
        onRouteToSettingsMenu?()
    }
    
}
