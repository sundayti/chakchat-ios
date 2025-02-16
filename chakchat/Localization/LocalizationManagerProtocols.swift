//
//  LocalizationManagerProtocols.swift
//  chakchat
//
//  Created by лизо4ка курунок on 16.02.2025.
//

import Foundation

// MARK: - LocalizationManagerProtocol
protocol LocalizationManagerProtocol {
    func localizedString(for key: String) -> String
    func setLanguage(_ languageCode: String, completion: @escaping () -> Void)
}
