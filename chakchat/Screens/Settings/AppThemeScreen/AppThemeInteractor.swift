//
//  AppThemeInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 22.02.2025.
//

import Foundation

// MARK: - AppThemeInteractor
final class AppThemeInteractor: AppThemeBusinessLogic {
    
    // MARK: - Properties
    private let presenter: AppThemePresentationLogic
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: AppThemePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func updateTheme(_ theme: AppTheme) {
        ThemeManager.shared.currentTheme = theme
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
