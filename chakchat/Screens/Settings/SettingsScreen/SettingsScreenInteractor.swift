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
    private let eventSubscriber: EventSubscriberProtocol
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    
    var onRouteToUserProfileSettings: (() -> Void)?
    var onRouteToConfidentialitySettings: (() -> Void)?
    var onRouteToNotificationsSettings: (() -> Void)?
    var onRouteToLanguageSettings: (() -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Initialization
    init(presenter: SettingsScreenPresentationLogic, 
         worker: SettingsScreenWorkerLogic,
         eventSubscriber: EventSubscriberProtocol,
         errorHandler: ErrorHandlerLogic,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.eventSubscriber = eventSubscriber
        self.errorHandler = errorHandler
        self.logger = logger
        
        subscribeToEvents()
    }
    
    // MARK: - User Data Loading
    func loadUserData() {
        os_log("Loaded user data in settings screen", log: logger, type: .default)
        worker.getUserData { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let userData):
                os_log("/me/get complete", log: logger, type: .info)
                self.showUserData(userData)
            case .failure(let failure):
                os_log("/me/get failed", log: logger, type: .info)
                _ = self.errorHandler.handleError(failure)
            }
        }
    }
    
    // MARK: - User Data Showing
    func showUserData(_ data: ProfileSettingsModels.ProfileUserData) {
        os_log("Passed user data in settings screen to presenter", log: logger, type: .default)
        presenter.showUserData(data)
    }
    
    // MARK: - New User Data Showing
    func showNewUserData(_ data: ProfileSettingsModels.ChangeableProfileUserData) {
        os_log("Passed new user data in settings screen to presenter", log: logger, type: .default)
        presenter.showNewUserData(data)
    }
    
    // MARK: - User Data Changed Event Handling
    private func subscribeToEvents() {
        eventSubscriber.subscribe(UpdateProfileDataEvent.self) { [weak self] event in
            self?.handleUserDataChangedEvent(event)
        }.store(in: &cancellables)
    }
    
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent) {
        os_log("Handled user data changes in settings screen", log: logger, type: .default)
        let newUserData = ProfileSettingsModels.ChangeableProfileUserData(nickname: event.newNickname,
                                                                       username: event.newUsername,
                                                                       photo: event.newPhoto,
                                                                       dateOfBirth: event.newBirth)
        showNewUserData(newUserData)
    }
    
    // MARK: - Routing
    func profileSettingsRoute() {
        os_log("Routed to profile settings screen", log: logger, type: .default)
        onRouteToUserProfileSettings?()
    }
    
    func confidentialitySettingsRoute() {
        os_log("Routed to confidentiality settings screen", log: logger, type: .default)
        onRouteToConfidentialitySettings?()
    }
    
    func notificationSettingsRoute() {
        os_log("Routed to notification settings screen", log: logger, type: .default)
        onRouteToNotificationsSettings?()
    }
    
    func languageSettingsRoute() {
        os_log("Routed to language settings screen", log: logger, type: .default)
        onRouteToLanguageSettings?()
    }
}
