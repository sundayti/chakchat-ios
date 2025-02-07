//
//  SettingsScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
import Combine
import OSLog

// MARK: - SettingsScreenInteractor
final class SettingsScreenInteractor: SettingsScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: SettingsScreenPresentationLogic
    private let worker: SettingsScreenWorkerLogic
    private var userData: SettingsScreenModels.UserData
    private let eventSubscriber: EventSubscriberProtocol
    private let logger: OSLog
    
    var onRouteToProfileSettings: (() -> Void)?
    var onRouteToConfidentialitySettings: (() -> Void)?
    var onRouteToNotificationsSettings: (() -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(presenter: SettingsScreenPresentationLogic, 
         worker: SettingsScreenWorkerLogic,
         userData: SettingsScreenModels.UserData,
         eventSubscriber: EventSubscriberProtocol,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.userData = userData
        self.eventSubscriber = eventSubscriber
        self.logger = logger
        
        subscribeToEvents()
    }
    
    // MARK: - User Data Loading
    func loadUserData() {
        os_log("Loaded user data in settings screen", log: logger, type: .default)
        showUserData(userData)
    }
    
    // MARK: - User Data Updating
    func updateUserData() {
        os_log("Updated user data in settings screen", log: logger, type: .default)
        showNewUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ data: SettingsScreenModels.UserData) {
        os_log("Passed user data in settings screen to presenter", log: logger, type: .default)
        presenter.showUserData(data)
    }
    
    // MARK: - New User Data Showing
    func showNewUserData(_ data: SettingsScreenModels.UserData) {
        os_log("Passed new user data in settings screen to presenter", log: logger, type: .default)
        presenter.showNewUserData(data)
    }
    
    // MARK: - Routing
    func profileSettingsRoute() {
        os_log("Routed to profile settings screen", log: logger, type: .default)
        onRouteToProfileSettings?()
    }
    
    func confidentialitySettingsRoute() {
        os_log("Routed to confidentiality settings screen", log: logger, type: .default)
        onRouteToConfidentialitySettings?()
    }
    
    func notificationSettingsRoute() {
        os_log("Routed to notification settings screen", log: logger, type: .default)
        onRouteToNotificationsSettings?()
    } 

    // MARK: - User Data Changed Event Handling
    private func subscribeToEvents() {
        eventSubscriber.subscribe(UpdateProfileDataEvent.self) { [weak self] event in
            self?.handleUserDataChangedEvent(event)
        }.store(in: &cancellables)
    }
    
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent) {
        os_log("Handled user data changes in settings screen", log: logger, type: .default)
        userData.nickname = event.newNickname
        userData.username = event.newUsername
        DispatchQueue.main.async {
            self.updateUserData()
        }
    }
}
