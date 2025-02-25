//
//  SettingsScreenProtocols.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit

// MARK: - SettingsScreenBusinessLogic
protocol SettingsScreenBusinessLogic {
    func profileSettingsRoute()
    func confidentialitySettingsRoute()
    func notificationSettingsRoute()
    func languageSettingsRoute()
    func appThemeSettingsRoute()
    func cacheSettingsRoute()
    func helpSettingsRoute()
    
    func showUserData(_ data: ProfileSettingsModels.ProfileUserData)
    func showNewUserData(_ data: ProfileSettingsModels.ChangeableProfileUserData)
    func showNewPhoto(_ photo: URL?)
    
    func loadUserData()
    
    func loadPhotoByURL(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
    
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent)
    func handlePhotoChangedEvent(_ event: UpdatePhotoEvent)
}

// MARK: - SettingsScreenPresentationLogic
protocol SettingsScreenPresentationLogic {
    func showUserData(_ data: ProfileSettingsModels.ProfileUserData)
    func showNewUserData(_ data: ProfileSettingsModels.ChangeableProfileUserData)
    func showNewPhoto(_ photo: URL?)
}

// MARK: - SettingsScreenWorkerLogic
protocol SettingsScreenWorkerLogic {
    func getUserData(completion: @escaping (Result<ProfileSettingsModels.ProfileUserData, Error>) -> Void)
    func loadPhoto(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void)
}
