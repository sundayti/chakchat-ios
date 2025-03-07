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
    var onRouteToCacheSettings: (() -> Void)?
    var onRouteToHelpSettings: (() -> Void)?
    
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
        os_log("Loading user data from userDefaults", log: logger, type: .default)
        let userData = worker.getUserData()
        showUserData(userData)
    }
    
    func loadPhotoByURL(_ url: URL, completion: @escaping (Result<UIImage, any Error>) -> Void) {
        worker.loadPhoto(url) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let image):
                completion(.success(image))
            case .failure(let failure):
                completion(.failure(failure))
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
    
    func showNewPhoto(_ photo: URL?) {
        os_log("Passed new photo in settings screen to presenter", log: logger, type: .default)
        presenter.showNewPhoto(photo)
    }
    
    
    // MARK: - User Data Changed Event Handling
    private func subscribeToEvents() {
        eventSubscriber.subscribe(UpdateProfileDataEvent.self) { [weak self] event in
            self?.handleUserDataChangedEvent(event)
        }.store(in: &cancellables)
        eventSubscriber.subscribe(UpdatePhotoEvent.self) { [weak self] event in
            self?.handlePhotoChangedEvent(event)
        }.store(in: &cancellables)
    }
        
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent) {
        os_log("Handled user data changes in settings screen", log: logger, type: .default)
        let newUserData = ProfileSettingsModels.ChangeableProfileUserData(name: event.newNickname,
                                                                       username: event.newUsername,
                                                                       dateOfBirth: event.newBirth)
        showNewUserData(newUserData)
    }
    
    func handlePhotoChangedEvent(_ event: UpdatePhotoEvent) {
        os_log("Handled photo changes event in settings screen", log: logger, type: .default)
        let newPhoto = event.newPhoto
        showNewPhoto(newPhoto)
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
    
    func cacheSettingsRoute() {
        os_log("Routed to cache settings screen", log: logger, type: .default)
        onRouteToCacheSettings?()
    }
    
    func helpSettingsRoute() {
        os_log("Routed to help settings screen", log: logger, type: .default)
        onRouteToHelpSettings?()
    }
}
