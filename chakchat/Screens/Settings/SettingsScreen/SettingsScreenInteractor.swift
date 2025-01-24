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
    var userData: SettingsScreenModels.UserData
    var onRouteToProfileSettings: (() -> Void)?
    
    init(presenter: SettingsScreenPresentationLogic, worker: SettingsScreenWorkerLogic, userData: SettingsScreenModels.UserData) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
    }
    
    func loadUserData() {
        showUserData(userData)
    }
    
    func showUserData(_ data: SettingsScreenModels.UserData) {
        presenter.showUserData(data)
    }
    
    func profileSettingsRoute() {
        onRouteToProfileSettings?()
    }
}
