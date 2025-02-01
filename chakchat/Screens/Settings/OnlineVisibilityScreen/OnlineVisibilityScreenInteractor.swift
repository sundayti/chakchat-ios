//
//  OnlineVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

// MARK: - OnlineVisibilityScreenInteractor
final class OnlineVisibilityScreenInteractor: OnlineVisibilityScreenBusinessLogic {

    // MARK: - Properties
    let presenter: OnlineVisibilityScreenPresentationLogic
    let worker: OnlineVisibilityScreenWorkerLogic
    let eventManager: EventPublisherProtocol
    var userData: OnlineVisibilityScreenModels.OnlineVisibility
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: OnlineVisibilityScreenPresentationLogic, worker: OnlineVisibilityScreenWorkerLogic, eventManager: EventPublisherProtocol, userData: OnlineVisibilityScreenModels.OnlineVisibility) {
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
    func showUserData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility) {
        presenter.showUserData(onlineVisibility)
    }
    
    // MARK: - New data Saving
    func saveNewData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility) {
        worker.saveNewOnlineVisibilityOption(onlineVisibility)
        let updateOnlineStatusEvent = UpdateOnlineStatusEvent(newOnlineStatus: onlineVisibility.onlineStatus)
        eventManager.publish(event: updateOnlineStatusEvent)
    }
    
    // MARK: - Routing
    func backToConfidentialityScreen() {
        onRouteToConfidentialityScreen?()
    }
}
