//
//  ConfidentialityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import Combine

// MARK: - ConfidentialityScreenInteractor
final class ConfidentialityScreenInteractor: ConfidentialityScreenBusinessLogic {
    
    // MARK: - Properties
    let presenter: ConfidentialityScreenPresentationLogic
    let worker: ConfidentialityScreenWorkerLogic
    var userData: ConfidentialitySettingsModels.ConfidentialityUserData
    let eventSubscriber: EventSubscriberProtocol
    
    private var cancellables = Set<AnyCancellable>()
    
    var onRouteToSettingsMenu: (() -> Void)?
    var onRouteToPhoneVisibilityScreen: (() -> Void)?
    var onRouteToBirthVisibilityScreen: (() -> Void)?
    var onRouteToOnlineVisibilityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ConfidentialityScreenPresentationLogic, worker: ConfidentialityScreenWorkerLogic, eventSubscriber: EventSubscriberProtocol, userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        self.presenter = presenter
        self.worker = worker
        self.eventSubscriber = eventSubscriber
        self.userData = userData
        
        subscribeToEvents()
    }
    
    // MARK: - User Data
    func loadUserData() {
        showUserData(userData)
    }
    
    // MARK: - User Data Updating
    func updateUserData() {
        showNewUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        presenter.showUserData(userData)
    }
    
    // MARK: - New User Data Showing
    func showNewUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        presenter.showNewUserData(userData)
    }
    
    private func subscribeToEvents() {
        eventSubscriber.subscribe(UpdatePhoneStatusEvent.self) { [weak self] event in
            self?.handlePhoneVisibilityChangeEvent(event)
        }.store(in: &cancellables)
        
        eventSubscriber.subscribe(UpdateBirthStatusEvent.self) { [weak self] event in
            self?.handleBirthVisibilityChangeEvent(event)
        }.store(in: &cancellables)
        
        eventSubscriber.subscribe(UpdateOnlineStatusEvent.self) { [weak self] event in
            self?.handleOnlineVisibilityChangeEvent(event)
        }.store(in: &cancellables)
    }
    
    // MARK: - Phone Visibility Change Event Handling
    func handlePhoneVisibilityChangeEvent(_ event: UpdatePhoneStatusEvent) {
        userData.phoneNumberState = event.newPhoneStatus
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
    
    // MARK: - Birth Visibility Change Event Handling
    func handleBirthVisibilityChangeEvent(_ event: UpdateBirthStatusEvent) {
        userData.dateOfBirthState = event.newBirthStatus
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
    
    // MARK: - Online Visibility Change Event Handling
    func handleOnlineVisibilityChangeEvent(_ event: UpdateOnlineStatusEvent) {
        userData.onlineStatus = event.newOnlineStatus
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
    
    // MARK: - Routing
    func routeToPhoneVisibilityScreen() {
        onRouteToPhoneVisibilityScreen?()
    }
    
    func routeToBirthVisibilityScreen() {
        onRouteToBirthVisibilityScreen?()
    }
    
    func routeToOnlineVisibilityScreen() {
        onRouteToOnlineVisibilityScreen?()
    }
    
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
