//
//  SettingsScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import UIKit
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
    var onRouteToAppThemeSettings: (() -> Void)?
    
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
    
    func unpackPhotoByUrl(_ url: URL) -> UIImage? {
        print(url.path)
        if FileManager.default.fileExists(atPath: url.path) {
            if let image = UIImage(contentsOfFile: url.path) {
                return image
            }
            return nil
        }
        return nil
    }
    
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent) {
        os_log("Handled user data changes in settings screen", log: logger, type: .default)
        let newUserData = ProfileSettingsModels.ChangeableProfileUserData(name: event.newNickname,
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
    
    func appThemeSettingsRoute() {
        os_log("Routed to app theme settings screen", log: logger, type: .default)
        onRouteToAppThemeSettings?()
    }
}
