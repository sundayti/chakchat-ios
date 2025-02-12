//
//  UserProfileScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//

import Foundation
protocol UserProfileScreenBusinessLogic {
    func backToSettingsMenu()
    func profileSettingsRoute()
    
    func loadUserData()
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
    func showNewUserData(_ userData: ProfileSettingsModels.ChangeableProfileUserData)
    
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent)
}
protocol UserProfileScreenPresentationLogic {
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData)
    func showNewUserData(_ userData: ProfileSettingsModels.ChangeableProfileUserData)
}
protocol UserProfileScreenWorkerLogic {
    func getUserData() -> ProfileSettingsModels.ProfileUserData
}
