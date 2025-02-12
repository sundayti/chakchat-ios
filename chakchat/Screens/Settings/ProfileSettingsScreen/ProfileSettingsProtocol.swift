//
//  ProfileSettingsProtocol.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation

// MARK: - ProfileSettingsBusinessLogic
protocol ProfileSettingsScreenBusinessLogic {
    func backToSettingsMenu()
    func saveNewData(_ newUserData: ProfileSettingsModels.ChangeableProfileUserData)
    func loadUserData()
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}

// MARK: - ProfileSettingsPresentationLogic
protocol ProfileSettingsScreenPresentationLogic {
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
}

protocol ProfileSettingsScreenWorkerLogic {
    func updateUserData(_ request: ProfileSettingsModels.ChangeableProfileUserData, completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
    func getUserData() -> ProfileSettingsModels.ProfileUserData
}
