//
//  PhoneVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - PhoneVisibilityScreenInteractor
final class PhoneVisibilityScreenInteractor: PhoneVisibilityScreenBusinessLogic {
    
    // MARK: - Properties
    let presenter: PhoneVisibilityScreenPresenter
    let worker: PhoneVisibilityScreenWorker
    let eventManager: EventPublisherProtocol
    var userData: PhoneVisibilityScreenModels.PhoneVisibility
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: PhoneVisibilityScreenPresenter, worker: PhoneVisibilityScreenWorker, eventManager: EventPublisherProtocol, userData: PhoneVisibilityScreenModels.PhoneVisibility) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.userData = userData
    }
    
    // MARK: - User Data Loading
    func loadUserData() {
        showUserData(userData)
    }
    
    // MARK: - User Data Showing
    func showUserData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility) {
        presenter.showUserData(phoneVisibility)
    }
    
    // MARK: - New Data Saving
    func saveNewData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility) {
        worker.saveNewPhoneVisibilityOption(phoneVisibility)
        let updatePhoneVisibilityEvent = UpdatePhoneStatusEvent(newPhoneStatus: phoneVisibility.phoneStatus)
        eventManager.publish(event: updatePhoneVisibilityEvent)
    }
    
    // MARK: - Routing
    func backToConfidentialityScreen() {
        onRouteToConfidentialityScreen?()
    }
}
