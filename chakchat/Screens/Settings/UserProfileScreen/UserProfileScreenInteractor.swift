//
//  UserProfileScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 06.02.2025.
//

import UIKit
import OSLog
import Combine

// MARK: - UserProfileScreenInteractor
final class UserProfileScreenInteractor: UserProfileScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: UserProfileScreenPresentationLogic
    private let worker: UserProfileScreenWorkerLogic
    private let eventSubscriber: EventSubscriberProtocol
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    
    private var cancellables = Set<AnyCancellable>()
    
    var onRouteToSettingsScreen: (() -> Void)?
    var onRouteToProfileSettingsScreen: (() -> Void)?
    
    // MARK: Initialization
    init(preseter: UserProfileScreenPresentationLogic,
         worker: UserProfileScreenWorkerLogic,
         eventSubscriber: EventSubscriberProtocol,
         errorHandler: ErrorHandlerLogic,
         logger: OSLog
    ) {
        self.presenter = preseter
        self.worker = worker
        self.eventSubscriber = eventSubscriber
        self.errorHandler = errorHandler
        self.logger = logger
        
        subscribeToEvents()
    }
    
    // MARK: - Public Methods
    // on this screen we are downloading data only from UserDefaults, because we have you already sent a get request to the server
    func loadUserData() {
        os_log("Loaded user data in user profile scree", log: logger, type: .default)
        let userData = worker.getUserData()
        showUserData(userData)
    }
    
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        os_log("Passed user data in user settings screen to presenter", log: logger, type: .default)
        presenter.showUserData(userData)
    }
    
    func showNewUserData(_ userData: ProfileSettingsModels.ChangeableProfileUserData) {
        os_log("Passed new user data in user settings screen to presenter", log: logger, type: .default)
        presenter.showNewUserData(userData)
    }
    
    func unpackPhotoByUrl(_ url: URL) -> UIImage? {
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                let imageData = try Data(contentsOf: url)
                if let image = UIImage(data: imageData) {
                    return image
                }
            } catch {
                os_log("Error during photo load", log: logger, type: .error)
            }
        } else {
            return nil
        }
        return nil
    }
    
    func handleUserDataChangedEvent(_ event: UpdateProfileDataEvent) {
        os_log("Handled user data changes in user profile screen", log: logger, type: .default)
        let newUserData = ProfileSettingsModels.ChangeableProfileUserData(nickname: event.newNickname,
                                                                          username: event.newUsername,
                                                                          photo: event.newPhoto,
                                                                          dateOfBirth: event.newBirth)
        showNewUserData(newUserData)
    }
    
    func backToSettingsMenu() {
        os_log("Routed to setting screen from user profile screen", log: logger, type: .default)
        onRouteToSettingsScreen?()
    }
    
    func profileSettingsRoute() {
        os_log("Routed to profile setting screen from user profile screen", log: logger, type: .default)
        onRouteToProfileSettingsScreen?()
    }
    
    private func subscribeToEvents() {
        eventSubscriber.subscribe(UpdateProfileDataEvent.self) { [weak self] event in
            self?.handleUserDataChangedEvent(event)
        }.store(in: &cancellables)
    }
}
