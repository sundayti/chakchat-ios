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
    private var userData: BirthVisibilityScreenModels.BirthVisibility
    private let logger: OSLog
    
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: BirthVisibilityScreenPresentationLogic, 
         worker: BirthVisibilityScreenWorkerLogic,
         eventManager: EventPublisherProtocol,
         userData: BirthVisibilityScreenModels.BirthVisibility,
         logger: OSLog
    ) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.userData = userData
        self.logger = logger
    }
    
    // MARK: - User Data Loading
    func loadUserData() {
        os_log("Loaded user data in birth visibility screen", log: logger, type: .default)
        showUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        os_log("Passed user data in birth visibility screen to presenter", log: logger, type: .default)
        presenter.showUserData(birthVisibility)
    }
    
    // MARK: - New Data Saving
    func saveNewData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        os_log("Saved new data in birth visibility screen", log: logger, type: .default)
        worker.saveNewBirthVisibilityOption(birthVisibility)
        userData.birthStatus = birthVisibility.birthStatus

    }
    
    // MARK: - Rounting
    func backToConfidentialityScreen() {
        let updateBirthStatusEvent = UpdateBirthStatusEvent(newBirthStatus: userData.birthStatus)
        os_log("Event published in birth visibility screen", log: logger, type: .default)
        eventManager.publish(event: updateBirthStatusEvent)
        os_log("Routed to confidentiality settings screen", log: logger, type: .default)
        onRouteToConfidentialityScreen?()
    }
}
