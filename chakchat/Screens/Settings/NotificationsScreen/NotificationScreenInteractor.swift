//
//  NotificationScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation

final class NotificationScreenInteractor: NotificationScreenBusinessLogic {
    
    let presenter: NotificationScreenPresentationLogic
    let worker: NotificationScreenWorkerLogic
    let eventManager: EventPublisherProtocol
    var userData: NotificationScreenModels.NotificationStatus
    var onRouteToSettingsMenu: (() -> Void)?
    
    init(presenter: NotificationScreenPresentationLogic, worker: NotificationScreenWorkerLogic, eventManager: EventPublisherProtocol, userData: NotificationScreenModels.NotificationStatus) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.userData = userData
    }
    
    func loadUserData() {
        showUserData(userData)
    }
    
    func showUserData(_ userData: NotificationScreenModels.NotificationStatus) {
        presenter.showUserData(userData)
    }
    
    func saveNewData(_ userData: NotificationScreenModels.NotificationStatus) {
        worker.saveNewData(userData)
    }
    
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
