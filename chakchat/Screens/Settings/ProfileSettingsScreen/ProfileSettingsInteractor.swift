//
//  ProfileSettingsInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
final class ProfileSettingsInteractor: ProfileSettingsBusinessLogic {
    
    var presenter: ProfileSettingsPresentationLogic
    var worker: ProfileSettingsWorkerLogic
    var userData: ProfileSettingsModels.ProfileUserData
    var eventPublisher: EventPublisherProtocol
    var onRouteToSettingsMenu: (() -> Void)?
    
    init(presenter: ProfileSettingsPresentationLogic, worker: ProfileSettingsWorkerLogic, userData: ProfileSettingsModels.ProfileUserData, eventPublisher: EventPublisherProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
        self.eventPublisher = eventPublisher
    }
    
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
    
    func saveNewData(_ newUserData: ProfileSettingsModels.ProfileUserData) {
        worker.saveNewData(newUserData)
        let updateProfileDataEvent = UpdateProfileDataEvent(newNickname: newUserData.nickname,
                                                                newUsername: newUserData.username)
        eventPublisher.publish(event: updateProfileDataEvent)
        onRouteToSettingsMenu?()
    }
    
    func loadUserData() {
        showUserData(userData)
    }
    
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        presenter.showUserData(userData)
    }
    
}
