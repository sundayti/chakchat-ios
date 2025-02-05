//
//  ProfileSettingsInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import OSLog

// MARK: - ProfileSettingsInteractor
final class ProfileSettingsInteractor: ProfileSettingsBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ProfileSettingsPresentationLogic
    private let worker: ProfileSettingsWorkerLogic
    private var userData: ProfileSettingsModels.ProfileUserData
    private let eventPublisher: EventPublisherProtocol
    private let logger: OSLog
    
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ProfileSettingsPresentationLogic, 
         worker: ProfileSettingsWorkerLogic,
         userData: ProfileSettingsModels.ProfileUserData,
         eventPublisher: EventPublisherProtocol,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
        self.eventPublisher = eventPublisher
        self.logger = logger
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        os_log("Routed to settings menu screen", log: logger, type: .default)
        onRouteToSettingsMenu?()
    }
    
    // MARK: - New data Saving
    func saveNewData(_ newUserData: ProfileSettingsModels.ProfileUserData) {
        os_log("Saved new data in profile settings screen", log: logger, type: .default)
        worker.saveNewData(newUserData)
        let updateProfileDataEvent = UpdateProfileDataEvent(newNickname: newUserData.nickname,
                                                                newUsername: newUserData.username)
        os_log("Published event in profile settings screen", log: logger, type: .default)
        eventPublisher.publish(event: updateProfileDataEvent)
        os_log("Routed to settings menu screen", log: logger, type: .default)
        onRouteToSettingsMenu?()
    }
    
    // MARK: - User Data Loading
    func loadUserData() {
        os_log("Loaded user data in profile settings screen", log: logger, type: .default)
        showUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        os_log("Passed user data in settigns screen to presenter", log: logger, type: .default)
        presenter.showUserData(userData)
    }
    
}
