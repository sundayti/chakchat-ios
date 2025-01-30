//
//  PhoneVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 30.01.2025.
//

import Foundation
final class PhoneVisibilityScreenInteractor: PhoneVisibilityScreenBusinessLogic {
    
    let presenter: PhoneVisibilityScreenPresenter
    let worker: PhoneVisibilityScreenWorker
    let eventManager: EventPublisherProtocol
    var userData: PhoneVisibilityScreenModels.PhoneVisibility
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    init(presenter: PhoneVisibilityScreenPresenter, worker: PhoneVisibilityScreenWorker, eventManager: EventPublisherProtocol, userData: PhoneVisibilityScreenModels.PhoneVisibility) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.userData = userData
    }
    
    func loadUserData() {
        showUserData(userData)
    }
    
    func showUserData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility) {
        presenter.showUserData(phoneVisibility)
    }
    
    func saveNewData(_ phoneVisibility: PhoneVisibilityScreenModels.PhoneVisibility) {
        worker.saveNewPhoneVisibilityOption(phoneVisibility)
        let updatePhoneVisibilityEvent = UpdatePhoneStatusEvent(newPhoneStatus: phoneVisibility.phoneStatus)
        eventManager.publish(event: updatePhoneVisibilityEvent)
    }
    
    func backToConfidentialityScreen() {
        onRouteToConfidentialityScreen?()
    }
}
