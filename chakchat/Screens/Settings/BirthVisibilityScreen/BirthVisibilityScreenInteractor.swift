//
//  BirthVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import OSLog

// MARK: - BirthVisibilityScreenInteractor
final class BirthVisibilityScreenInteractor: BirthVisibilityScreenBusinessLogic {

    // MARK: - Properties
    private let presenter: BirthVisibilityScreenPresentationLogic
    private let worker: BirthVisibilityScreenWorkerLogic
    private let eventManager: EventPublisherProtocol
    private let errorHandler: ErrorHandlerLogic
    private let logger: OSLog
    private let userRestrictionsSnap: ConfidentialitySettingsModels.ConfidentialityUserData
    
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: BirthVisibilityScreenPresentationLogic, 
         worker: BirthVisibilityScreenWorkerLogic,
         eventManager: EventPublisherProtocol,
         errorHandler: ErrorHandlerLogic,
         logger: OSLog,
         userRestrictionsSnap: ConfidentialitySettingsModels.ConfidentialityUserData
    ) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.errorHandler = errorHandler
        self.logger = logger
        self.userRestrictionsSnap = userRestrictionsSnap
    }
    
    // MARK: - Public Methods
    func loadUserRestrictions() {
        os_log("Loaded user data in birth visibility screen", log: logger, type: .default)
        showUserRestrictions(userRestrictionsSnap)
    }
    
    func showUserRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        os_log("Passed user data in birth visibility screen to presenter", log: logger, type: .default)
        presenter.showUserRestrictions(userRestrictions)
    }
    
    func saveNewRestrictions(_ userRestrictions: ConfidentialitySettingsModels.ConfidentialityUserData) {
        os_log("Saved new data in birth visibility screen", log: logger, type: .default)
        worker.saveNewRestrictions(userRestrictions)
    }
    
    // MARK: - Rounting
    func backToConfidentialityScreen(_ birthRestriction: String) {
        let newUserRestrictions = ConfidentialitySettingsModels.ConfidentialityUserData(
            phone: userRestrictionsSnap.phone,
            dateOfBirth: ConfidentialityDetails(openTo: birthRestriction, specifiedUsers: nil))
        saveNewRestrictions(newUserRestrictions)
        let updateRestrictionsEvent = UpdateRestrictionsEvent(newPhone: newUserRestrictions.phone,
                                                              newDateOfBirth: newUserRestrictions.dateOfBirth)
        os_log("Event published in birth visibility screen", log: logger, type: .default)
        eventManager.publish(event: updateRestrictionsEvent)
        os_log("Routed to confidentiality settings screen", log: logger, type: .default)
        onRouteToConfidentialityScreen?()
    }
}
