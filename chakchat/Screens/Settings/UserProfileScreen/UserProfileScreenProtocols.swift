//
//  UserProfileScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//

import Foundation

// MARK: - UserProfileScreenBusinessLogic
protocol UserProfileScreenBusinessLogic {
    func backToSettingsMenu()
    func profileSettingsRoute()
    
    func loadUserData()
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
    func showNewUserData(_ userData: ProfileSettingsModels.ChangeableProfileUserData)
    
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent)
}

// MARK: - UserProfileScreenPresentationLogic
protocol UserProfileScreenPresentationLogic {
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
    func showNewUserData(_ userData: ProfileSettingsModels.ChangeableProfileUserData)
}

// MARK: - UserProfileScreenWorkerLogic
protocol UserProfileScreenWorkerLogic {
    func getUserData() -> ProfileSettingsModels.ProfileUserData
}
