//
//  ChatsScreenInteractor.swift
//  chakchat
//
//  Created by Кирилл Исаев on 21.01.2025.
//

import Foundation
final class ChatsScreenInteractor: ChatsScreenBusinessLogic {
    
    var presenter: ChatsScreenPresentationLogic
    var worker: ChatsScreenWorkerLogic
    
    var onRouteToSettings: (() -> Void)?
    
    init(presenter: ChatsScreenPresentationLogic, worker: ChatsScreenWorkerLogic) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func routeToSettingsScreen() {
        onRouteToSettings?()
    }
    
}
