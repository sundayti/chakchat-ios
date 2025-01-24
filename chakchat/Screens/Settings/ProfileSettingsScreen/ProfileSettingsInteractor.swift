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
    
    init(presenter: ProfileSettingsPresentationLogic, worker: ProfileSettingsWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
}
