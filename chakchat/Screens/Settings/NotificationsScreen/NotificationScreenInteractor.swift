//
//  NotificationScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

// MARK: - NotificationScreenInteractor
final class NotificationScreenInteractor: NotificationScreenBusinessLogic {
    
    // MARK: - Properties
    let presenter: NotificationScreenPresentationLogic
    let worker: NotificationScreenWorkerLogic
    let eventManager: EventPublisherProtocol
    var userData: NotificationScreenModels.NotificationStatus
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: NotificationScreenPresentationLogic, worker: NotificationScreenWorkerLogic, eventManager: EventPublisherProtocol, userData: NotificationScreenModels.NotificationStatus) {
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
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus) {
        presenter.showUserData(userData)
    }
    
    // MARK: - New Data Saving
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus) {
        worker.saveNewData(userData)
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
