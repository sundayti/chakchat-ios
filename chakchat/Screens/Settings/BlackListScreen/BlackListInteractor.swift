//
//  BlackListInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 24.02.2025.
//

import Foundation

// MARK: - BlackListInteractor
final class BlackListInteractor: BlackListBusinessLogic {
    
    // MARK: - Properties
    private let presenter: BlackListPresentationLogic
    var onRouteToConfidantialityScreen: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: BlackListPresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Routing
    func backToConfidantialityScreen() {
        onRouteToConfidantialityScreen?()
    }
}
