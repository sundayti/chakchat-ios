//
//  LanguageProtocols.swift
//  chakchat
//
//  Created by лизо4ка курунок on 15.02.2025.
//

import Foundation

protocol LanguageBusinessLogic {
    func backToSettingsMenu()

    func updateLanguage(to languageCode: String, completion: @escaping () -> Void)
}

protocol LanguagePresentationLogic {
}

protocol LanguageWorkerLogic {
    func updateLanguage()
}
