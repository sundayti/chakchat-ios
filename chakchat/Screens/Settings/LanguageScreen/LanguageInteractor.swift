//
//  LanguageInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 15.02.2025.
//

import Foundation

// MARK: - LanguageInteractor
final class LanguageInteractor: LanguageBusinessLogic {
    
    // MARK: - Properties
    private let presenter: LanguagePresentationLogic
    var onRouteToSettingsMenu: (() -> Void)?
    
    // MARK: - Initialization
    init(presenter: LanguagePresentationLogic) {
        self.presenter = presenter
    }
    
    // MARK: - Public Methods
    func updateLanguage(to languageCode: String, completion: @escaping () -> Void) {
        LocalizationManager.shared.setLanguage(languageCode) {
            completion()
        }
    }
    
    // MARK: - Routing
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
