//
//  OnlineVisibilityScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 31.01.2025.
//

import Foundation
final class OnlineVisibilityScreenInteractor: OnlineVisibilityScreenBusinessLogic {

    let presenter: OnlineVisibilityScreenPresentationLogic
    let worker: OnlineVisibilityScreenWorkerLogic
    let eventManager: EventPublisherProtocol
    var userData: OnlineVisibilityScreenModels.OnlineVisibility
    var onRouteToConfidentialityScreen: (() -> Void)?
    
    init(presenter: OnlineVisibilityScreenPresentationLogic, worker: OnlineVisibilityScreenWorkerLogic, eventManager: EventPublisherProtocol, userData: OnlineVisibilityScreenModels.OnlineVisibility) {
        self.presenter = presenter
        self.worker = worker
        self.eventManager = eventManager
        self.userData = userData
    }
    
    func loadUserData() {
        showUserData(userData)
    }
    
    func showUserData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility) {
        presenter.showUserData(onlineVisibility)
    }
    
    func saveNewData(_ onlineVisibility: OnlineVisibilityScreenModels.OnlineVisibility) {
        worker.saveNewOnlineVisibilityOption(onlineVisibility)
        let updateOnlineStatusEvent = UpdateOnlineStatusEvent(newOnlineStatus: onlineVisibility.onlineStatus)
        eventManager.publish(event: updateOnlineStatusEvent)
    }
    
    func backToConfidentialityScreen() {
        onRouteToConfidentialityScreen?()
    }
}
