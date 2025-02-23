//
//  HelpInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 23.02.2025.
//

import Foundation

// MARK: - HelpInteractor
final class HelpInteractor: HelpBusinessLogic {
    
    // MARK: - Properties
    private let presenter: HelpPresentationLogic
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: HelpPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
