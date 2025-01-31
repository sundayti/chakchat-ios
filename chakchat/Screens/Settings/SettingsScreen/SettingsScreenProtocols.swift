//
//  SettingsScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
protocol SettingsScreenBusinessLogic {
    func profileSettingsRoute()
    func confidentialitySettingsRoute()
    func notificationSettingsRoute()
    
    func showUserData(_ data: SettingsScreenModels.UserData)
    func loadUserData()
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent)
}
protocol SettingsScreenPresentationLogic {
    func showUserData(_ data: SettingsScreenModels.UserData)
    func showNewUserData(_ data: SettingsScreenModels.UserData)
}
protocol SettingsScreenWorkerLogic {
    func loadUserProfileData() -> ProfileSettingsModels.ProfileUserData
}
