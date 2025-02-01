//
//  ProfileSettingsInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation

// MARK: - ProfileSettingsInteractor
final class ProfileSettingsInteractor: ProfileSettingsBusinessLogic {
    
    // MARK: - Properties
    var presenter: ProfileSettingsPresentationLogic
    var worker: ProfileSettingsWorkerLogic
    var userData: ProfileSettingsModels.ProfileUserData
    var eventPublisher: EventPublisherProtocol
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ProfileSettingsPresentationLogic, worker: ProfileSettingsWorkerLogic, userData: ProfileSettingsModels.ProfileUserData, eventPublisher: EventPublisherProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
        self.eventPublisher = eventPublisher
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
    
    // MARK: - New data Saving
    func saveNewData(_ newUserData: ProfileSettingsModels.ProfileUserData) {
        worker.saveNewData(newUserData)
        let updateProfileDataEvent = UpdateProfileDataEvent(newNickname: newUserData.nickname,
                                                                newUsername: newUserData.username)
        eventPublisher.publish(event: updateProfileDataEvent)
        onRouteToSettingsMenu?()
    }
    
    // MARK: - User Data Loading
    func loadUserData() {
        showUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        presenter.showUserData(userData)
    }
    
}
