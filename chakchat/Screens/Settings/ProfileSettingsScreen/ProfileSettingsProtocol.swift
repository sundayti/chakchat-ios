//
//  ProfileSettingsProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
protocol ProfileSettingsBusinessLogic {
    func backToSettingsMenu()
    func saveNewData(_ newUserData: ProfileSettingsModels.ProfileUserData)
    func loadUserData()
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}
protocol ProfileSettingsPresentationLogic {
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}
protocol ProfileSettingsWorkerLogic {
    func saveNewData(_ userData: ProfileSettingsModels.ProfileUserData)
}
