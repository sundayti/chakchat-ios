//
//  SettingsScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
protocol SettingsScreenBusinessLogic {
    func profileSettingsRoute()
    func showUserData(_ data: SettingsScreenModels.UserData)
    func loadUserData()
}
protocol SettingsScreenPresentationLogic {
    func showUserData(_ data: SettingsScreenModels.UserData)
}
protocol SettingsScreenWorkerLogic {
    
}
