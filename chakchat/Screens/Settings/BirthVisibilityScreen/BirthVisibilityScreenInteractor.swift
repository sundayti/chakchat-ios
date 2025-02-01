//
//  BirthVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation

// MARK: - BirthVisibilityScreenInteractor
final class BirthVisibilityScreenInteractor: BirthVisibilityScreenBusinessLogic {

    // MARK: - Properties
    let presenter: BirthVisibilityScreenPresentationLogic
    let worker: BirthVisibilityScreenWorkerLogic
    let eventManager: EventPublisherProtocol
    var userData: BirthVisibilityScreenModels.BirthVisibility
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: BirthVisibilityScreenPresentationLogic, worker: BirthVisibilityScreenWorkerLogic, eventManager: EventPublisherProtocol, userData: BirthVisibilityScreenModels.BirthVisibility) {
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
    func showUserData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        presenter.showUserData(birthVisibility)
    }
    
    // MARK: - New Data Saving
    func saveNewData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        worker.saveNewBirthVisibilityOption(birthVisibility)
        let updateBirthStatusEvent = UpdateBirthStatusEvent(newBirthStatus: birthVisibility.birthStatus)
        eventManager.publish(event: updateBirthStatusEvent)
    }
    
    // MARK: - Rounting
    func backToConfidentialityScreen() {
        onRouteToConfidentialityScreen?()
    }
}
