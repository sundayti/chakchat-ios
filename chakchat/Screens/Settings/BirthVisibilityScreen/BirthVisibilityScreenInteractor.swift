//
//  BirthVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class BirthVisibilityScreenInteractor: BirthVisibilityScreenBusinessLogic {

    let presenter: BirthVisibilityScreenPresentationLogic
    let worker: BirthVisibilityScreenWorkerLogic
    let eventManager: EventPublisherProtocol
    var userData: BirthVisibilityScreenModels.BirthVisibility
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    init(presenter: BirthVisibilityScreenPresentationLogic, worker: BirthVisibilityScreenWorkerLogic, eventManager: EventPublisherProtocol, userData: BirthVisibilityScreenModels.BirthVisibility) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.userData = userData
    }
    
    func loadUserData() {
        showUserData(userData)
    }
    
    func showUserData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        presenter.showUserData(birthVisibility)
    }
    
    func saveNewData(_ birthVisibility: BirthVisibilityScreenModels.BirthVisibility) {
        worker.saveNewBirthVisibilityOption(birthVisibility)
        let updateBirthStatusEvent = UpdateBirthStatusEvent(newBirthStatus: birthVisibility.birthStatus)
        eventManager.publish(event: updateBirthStatusEvent)
    }
    
    func backToConfidentialityScreen() {
        onRouteToConfidentialityScreen?()
    }
}
