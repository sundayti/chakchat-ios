//
//  ChatsScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation

// MARK: - ChatsScreenInteractor
final class ChatsScreenInteractor: ChatsScreenBusinessLogic {
    
    // MARK: - Properties
    var presenter: ChatsScreenPresentationLogic
    var worker: ChatsScreenWorkerLogic
    
    var onRouteToSettings: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: ChatsScreenPresentationLogic, worker: ChatsScreenWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    // MARK: - Routing 
    func routeToSettingsScreen() {
        onRouteToSettings?()
    }
    
}
