//
//  ConfidentialityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
import Combine
import OSLog

// MARK: - ConfidentialityScreenInteractor
final class ConfidentialityScreenInteractor: ConfidentialityScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ConfidentialityScreenPresentationLogic
    private let worker: ConfidentialityScreenWorkerLogic
    private var userData: ConfidentialitySettingsModels.ConfidentialityUserData
    private let eventSubscriber: EventSubscriberProtocol
    private let logger: OSLog
    
    private var cancellables = Set<AnyCancellable>()
    
    var onRouteToSettingsMenu: (() -> Void)?
    var onRouteToPhoneVisibilityScreen: (() -> Void)?
    var onRouteToBirthVisibilityScreen: (() -> Void)?
    var onRouteToOnlineVisibilityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ConfidentialityScreenPresentationLogic, 
         worker: ConfidentialityScreenWorkerLogic,
         eventSubscriber: EventSubscriberProtocol,
         userData: ConfidentialitySettingsModels.ConfidentialityUserData,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.eventSubscriber = eventSubscriber
        self.userData = userData
        self.logger = logger
        
        subscribeToEvents()
    }
    
    // MARK: - User Data
    func loadUserData() {
        os_log("Loaded user data in confidentiality settings screen", log: logger, type: .default)
        showUserData(userData)
    }
    
    // MARK: - User Data Updating
    func updateUserData() {
        os_log("Loaded new user data in profile settings screen", log: logger, type: .default)
        showNewUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        os_log("Passed user data in confidentiality settings screen to presenter", log: logger, type: .default)
        presenter.showUserData(userData)
    }
    
    // MARK: - New User Data Showing
    func showNewUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        os_log("Passed new user data in confidentiality settings screen to presenter", log: logger, type: .default)
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
        os_log("Handled user data changes in phone visibility screen", log: logger, type: .default)
        userData.phoneNumberState = event.newPhoneStatus
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
    
    // MARK: - Birth Visibility Change Event Handling
    func handleBirthVisibilityChangeEvent(_ event: UpdateBirthStatusEvent) {
        os_log("Handled user data changes in birth visibility screen", log: logger, type: .default)
        userData.dateOfBirthState = event.newBirthStatus
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
    
    // MARK: - Online Visibility Change Event Handling
    func handleOnlineVisibilityChangeEvent(_ event: UpdateOnlineStatusEvent) {
        os_log("Handled user data changes in online status visibility screen", log: logger, type: .default)
        userData.onlineStatus = event.newOnlineStatus
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
    
    // MARK: - Routing
    func routeToPhoneVisibilityScreen() {
        os_log("Routed to phone visibility screen", log: logger, type: .default)
        onRouteToPhoneVisibilityScreen?()
    }
    
    func routeToBirthVisibilityScreen() {
        os_log("Routed to birth visibility screen", log: logger, type: .default)
        onRouteToBirthVisibilityScreen?()
    }
    
    func routeToOnlineVisibilityScreen() {
        os_log("Routed to online status visibility screen", log: logger, type: .default)
        onRouteToOnlineVisibilityScreen?()
    }
    
    func backToSettingsMenu() {
        os_log("Routed to settings menu screen", log: logger, type: .default)
        onRouteToSettingsMenu?()
    }
}
