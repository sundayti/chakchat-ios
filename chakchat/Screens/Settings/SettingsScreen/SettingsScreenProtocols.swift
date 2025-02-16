//
//  SettingsScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation

// MARK: - SettingsScreenBusinessLogic
protocol SettingsScreenBusinessLogic {
    func profileSettingsRoute()
    func confidentialitySettingsRoute()
    func notificationSettingsRoute()
    func languageSettingsRoute()
    
    func showUserData(_ data: ProfileSettingsModels.ProfileUserData)
    func showNewUserData(_ data: ProfileSettingsModels.ChangeableProfileUserData)
    func loadUserData()
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent)
}

// MARK: - SettingsScreenPresentationLogic
protocol SettingsScreenPresentationLogic {
    func showUserData(_ data: ProfileSettingsModels.ProfileUserData)
    func showNewUserData(_ data: ProfileSettingsModels.ChangeableProfileUserData)
}

// MARK: - SettingsScreenWorkerLogic
protocol SettingsScreenWorkerLogic {
    func getUserData(completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
}
