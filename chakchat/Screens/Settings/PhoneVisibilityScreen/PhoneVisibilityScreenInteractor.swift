//
//  PhoneVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
import OSLog

// MARK: - PhoneVisibilityScreenInteractor
final class PhoneVisibilityScreenInteractor: PhoneVisibilityScreenBusinessLogic {
    
    // MARK: - Properties
    private let presenter: PhoneVisibilityScreenPresenter
    private let worker: PhoneVisibilityScreenWorker
    private let eventManager: EventPublisherProtocol
    private var userData: PhoneVisibilityScreenModels.PhoneVisibility
    private let logger: OSLog
    
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: PhoneVisibilityScreenPresenter, 
         worker: PhoneVisibilityScreenWorker,
         eventManager: EventPublisherProtocol,
         userData: PhoneVisibilityScreenModels.PhoneVisibility, 
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
        os_log("Loaded user data in phone visibility screen", log: logger, type: .default)
        showUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility) {
        os_log("Passed user data in phone visibility screen to presenter", log: logger, type: .default)
        presenter.showUserData(phoneVisibility)
    }
    
    // MARK: - New Data Saving
    func saveNewData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility) {
        os_log("Saved new data in phone visibility screen", log: logger, type: .default)
        worker.saveNewPhoneVisibilityOption(phoneVisibility)
        userData.phoneStatus = phoneVisibility.phoneStatus
    }
    
    // MARK: - Routing
    func backToConfidentialityScreen() {
        let updatePhoneVisibilityEvent = UpdatePhoneStatusEvent(newPhoneStatus: userData.phoneStatus)
        os_log("Event published in phone visibility screen", log: logger, type: .default)
        eventManager.publish(event: updatePhoneVisibilityEvent)
        os_log("Routed to confidentiality settings screen", log: logger, type: .default)
        onRouteToConfidentialityScreen?()
    }
}
