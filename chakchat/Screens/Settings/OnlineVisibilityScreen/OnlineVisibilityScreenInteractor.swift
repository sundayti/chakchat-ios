//
//  OnlineVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
import OSLog

// MARK: - OnlineVisibilityScreenInteractor
final class OnlineVisibilityScreenInteractor: OnlineVisibilityScreenBusinessLogic {

    // MARK: - Properties
    private let presenter: OnlineVisibilityScreenPresentationLogic
    private let worker: OnlineVisibilityScreenWorkerLogic
    private let eventManager: EventPublisherProtocol
    private var userData: OnlineVisibilityScreenModels.OnlineVisibility
    private let logger: OSLog
    
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: OnlineVisibilityScreenPresentationLogic, 
         worker: OnlineVisibilityScreenWorkerLogic,
         eventManager: EventPublisherProtocol,
         userData: OnlineVisibilityScreenModels.OnlineVisibility,
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
        os_log("Loaded user data in online status visibility screen", log: logger, type: .default)
        showUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility) {
        os_log("Passed user data in online status visibility screen to presenter", log: logger, type: .default)
        presenter.showUserData(onlineVisibility)
    }
    
    // MARK: - New data Saving
    func saveNewData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility) {
        os_log("Saved new data in online status visibility screen", log: logger, type: .default)
        worker.saveNewOnlineVisibilityOption(onlineVisibility)
        userData.onlineStatus = onlineVisibility.onlineStatus
    }
    
    // MARK: - Routing
    func backToConfidentialityScreen() {
        let updateOnlineStatusEvent = UpdateOnlineStatusEvent(newOnlineStatus: userData.onlineStatus)
        os_log("Event published in online status visibility screen", log: logger, type: .default)
        eventManager.publish(event: updateOnlineStatusEvent)
        os_log("Routed to confidentiality settings screen", log: logger, type: .default)
        onRouteToConfidentialityScreen?()
    }
}
