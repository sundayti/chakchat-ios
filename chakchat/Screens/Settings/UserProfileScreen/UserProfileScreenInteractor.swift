//
//  UserProfileScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//

import Foundation
import OSLog

final class UserProfileScreenInteractor: UserProfileScreenBusinessLogic {
    
    private let presenter: UserProfileScreenPresentationLogic
    private let worker: UserProfileScreenWorkerLogic
    private var userData: ProfileSettingsModels.ProfileUserData
    private let logger: OSLog
    
    var onRouteToSettingsScreen: (() -> Void)?
    var onRouteToProfileSettingsScreen: (() -> Void)?
    
    init(preseter: UserProfileScreenPresentationLogic, 
         worker: UserProfileScreenWorkerLogic,
         userData: ProfileSettingsModels.ProfileUserData,
         logger: OSLog
    ) {
        self.presenter = preseter
        self.worker = worker
        self.userData = userData
        self.logger = logger
    }
    
    func loadUserData() {
        os_log("Loaded user data in user profile scree", log: logger, type: .default)
        showUserData(userData)
    }
    
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        os_log("Passed user data in user settings screen to presenter", log: logger, type: .default)
        presenter.showUserData(userData)
    }
    
    func updateUserData() {
        os_log("Updated user data in user settings screen", log: logger, type: .default)
        showNewUserData(userData)
    }
    
    func showNewUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        os_log("Passed new user data in user settings screen to presenter", log: logger, type: .default)
        presenter.showNewUserData(userData)
    }
    
    internal func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent) {
        os_log("Handled user data changes in user profile screen", log: logger, type: .default)
        userData.nickname = event.newNickname
        userData.username = event.newUsername
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
    
    func backToSettingsMenu() {
        os_log("Routed to setting screen from user profile screen", log: logger, type: .default)
        onRouteToSettingsScreen?()
    }
    
    func profileSettingsRoute() {
        os_log("Routed to profile setting screen from user profile screen", log: logger, type: .default)
        onRouteToProfileSettingsScreen?()
    }
}
