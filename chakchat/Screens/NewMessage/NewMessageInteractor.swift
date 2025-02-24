//
//  NewMessageInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import Foundation

// MARK: - NewMessageInteractor
final class NewMessageInteractor: NewMessageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: NewMessagePresentationLogic
    var onRouteToChatsScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: NewMessagePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Routing
    func backToChatsScreen() {
        onRouteToChatsScreen?()
    }
}

