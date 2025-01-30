//
//  ConfidentialityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
final class ConfidentialityScreenInteractor: ConfidentialityScreenBusinessLogic {
    
    let presenter: ConfidentialityScreenPresentationLogic
    let worker: ConfidentialityScreenWorkerLogic
    var userData: ConfidentialitySettingsModels.ConfidentialityUserData
    let eventPublisher: EventPublisherProtocol
    var onRouteToSettingsMenu: (() -> Void)?
    var onRouteToPhoneVisibilityScreen: (() -> Void)?
    var onRouteToBirthVisibilityScreen: (() -> Void)?
    
    init(presenter: ConfidentialityScreenPresentationLogic, worker: ConfidentialityScreenWorkerLogic, eventPublisher: EventPublisherProtocol, userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        self.presenter = presenter
        self.worker = worker
        self.eventPublisher = eventPublisher
        self.userData = userData
    }
    
    func loadUserData() {
        showUserData(userData)
    }
    
    func updateUserData() {
        showNewUserData(userData)
    }
    
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        presenter.showUserData(userData)
    }
    
    func showNewUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        presenter.showNewUserData(userData)
    }
    
    func handlePhoneVisibilityChangeEvent(_ event: UpdatePhoneStatusEvent) {
        userData.phoneNumberState = event.newPhoneStatus
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
    
    func handleBirthVisibilityChangeEvent(_ event: UpdateBirthStatusEvent) {
        userData.dateOfBirthState = event.newBirthStatus
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
    
    func routeToPhoneVisibilityScreen() {
        onRouteToPhoneVisibilityScreen?()
    }
    
    func routeToBirthVisibilityScreen() {
        onRouteToBirthVisibilityScreen?()
    }
    
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
