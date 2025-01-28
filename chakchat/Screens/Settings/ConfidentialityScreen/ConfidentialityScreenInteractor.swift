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
    let eventPublisher: EventPublisherProtocol
    var onRouteToSettingsMenu: (() -> Void)?
    
    init(presenter: ConfidentialityScreenPresentationLogic, worker: ConfidentialityScreenWorkerLogic, eventPublisher: EventPublisherProtocol) {
        self.presenter = presenter
        self.worker = worker
        self.eventPublisher = eventPublisher
    }
    
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
