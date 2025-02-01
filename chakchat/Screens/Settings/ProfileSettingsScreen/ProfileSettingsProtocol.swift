//
//  ProfileSettingsProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation

// MARK: - ProfileSettingsBusinessLogic
protocol ProfileSettingsBusinessLogic {
    func backToSettingsMenu()
    func saveNewData(_ newUserData: ProfileSettingsModels.ProfileUserData)
    func loadUserData()
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}

// MARK: - ProfileSettingsPresentationLogic
protocol ProfileSettingsPresentationLogic {
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}

// MARK: - ProfileSettingsWorkerLogic
protocol ProfileSettingsWorkerLogic {
    func saveNewData(_ userData: ProfileSettingsModels.ProfileUserData)
}
