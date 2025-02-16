//
//  LanguageInteractor.swift
//  chakchat
//
//  Created by лизо4ка курунок on 15.02.2025.
//

import Foundation

final class LanguageInteractor: LanguageBusinessLogic {
    
    private let presenter: LanguagePresentationLogic

    var onRouteToSettingsMenu: (() -> Void)?
    
    init(presenter: LanguagePresentationLogic) {
        self.presenter = presenter
    }
    
    func updateLanguage(to languageCode: String, completion: @escaping () -> Void) {
        LocalizationManager.shared.setLanguage(languageCode) {
            completion()
        }
    }
    
    func backToSettingsMenu() {
        onRouteToSettingsMenu?()
    }
}
