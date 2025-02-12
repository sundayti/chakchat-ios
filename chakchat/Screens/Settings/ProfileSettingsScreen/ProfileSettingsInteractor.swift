//
//  ProfileSettingsInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 24.01.2025.
//

import Foundation
import OSLog

// MARK: - ProfileSettingsInteractor
final class ProfileSettingsInteractor: ProfileSettingsScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: ProfileSettingsScreenPresentationLogic
    private let worker: ProfileSettingsScreenWorkerLogic
    private let eventPublisher: EventPublisherProtocol
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ProfileSettingsScreenPresentationLogic,
         worker: ProfileSettingsScreenWorkerLogic,
         eventPublisher: EventPublisherProtocol,
         errorHandler: ErrorHandlerLogic,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.eventPublisher = eventPublisher
        self.errorHandler = errorHandler
        self.logger = logger
    }
    

    // MARK: - User Data Loading
    func loadUserData() {
        os_log("Loaded user data in profile settings screen", log: logger, type: .default)
        let userData = worker.getUserData()
        showUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ userData: ProfileSettingsModels.ProfileUserData) {
        os_log("Passed user data in settigns screen to presenter", log: logger, type: .default)
        presenter.showUserData(userData)
    }
    
    // MARK: - New data Saving
    func saveNewData(_ newUserData: ProfileSettingsModels.ChangeableProfileUserData) {
        os_log("Saved new data in profile settings screen", log: logger, type: .default)
        worker.updateUserData(newUserData) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let newUserData):
                os_log("/me/put complete", log: logger, type: .info)
                let updateProfileDataEvent = UpdateProfileDataEvent(
                    newNickname: newUserData.nickname,
                    newUsername: newUserData.username,
                    newPhoto: newUserData.photo,
                    newBirth: newUserData.dateOfBirth
                )
                os_log("Published event in profile settings screen", log: logger, type: .default)
                eventPublisher.publish(event: updateProfileDataEvent)
            case .failure(let failure):
                os_log("/me/put failed", log: logger, type: .info)
                let errorID = self.errorHandler.handleError(failure)
            }
        }
        os_log("Routed to settings menu screen", log: logger, type: .default)
        onRouteToSettingsMenu?()
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        os_log("Routed to settings menu screen", log: logger, type: .default)
        onRouteToSettingsMenu?()
    }
    
}
