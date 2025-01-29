//
//  ConfidentialityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 28.01.2025.
//

import Foundation
final class ConfidentialityScreenInteractor: ConfidentialityScreenBusinessLogic {
    
    let presenter: ConfidentialityScreenPresentationLogic
    let worker: ConfidentialityScreenWorkerLogic
    var userData: ConfidentialitySettingsModels.ConfidentialityUserData
    let eventPublisher: EventPublisherProtocol
    var onRouteToSettingsMenu: (() -> Void)?
    
    init(presenter: ConfidentialityScreenPresentationLogic, worker: ConfidentialityScreenWorkerLogic, eventPublisher: EventPublisherProtocol, userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        self.presenter = presenter
        self.worker = worker
        self.eventPublisher = eventPublisher
        self.userData = userData
    }
    
    func loadUserData() {
        showUserData(userData)
    }
    
    func showUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        presenter.showUserData(userData)
    }
    
    func saveNewUserData(_ userData: ConfidentialitySettingsModels.ConfidentialityUserData) {
        worker.saveNewData(userData)
    }
    
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
