//
//  LanguageProtocols.swift
//  chakchat
//
//  Created by лизо4ка курунок on 15.02.2025.
//

import Foundation

// MARK: - Language Protocols
protocol LanguageBusinessLogic {
    func backToSettingsMenu()
    func updateLanguage(to languageCode: String, completion: @escaping () -> Void)
}

protocol LanguagePresentationLogic {
}
